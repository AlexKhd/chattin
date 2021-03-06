class UsersController < ApplicationController
  before_action :check_if_admin, only: [:index]
  before_action :authenticate_user!, only: [:show, :edit]
  before_action :set_user, only: [:show,
                                  :edit,
                                  :update,
                                  :destroy,
                                  :finish_signup
                                 ]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user == current_user ? @user : current_user, bypass: true)
        format.html { redirect_to @user, notice: 'Your profile was updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def finish_signup
    # authorize! :update, @user
    current_user.skip_confirmation!
    if request.patch? && params[:user] # && params[:user][:email]
      if current_user.update(user_params)
        current_user.skip_confirmation!
        sign_in(current_user, bypass: true)
        redirect_to root_path, notice: t(:profile_updated)
      else
        @show_errors = true
      end
    end
  end

  def destroy
    # authorize! :delete, @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'User was deleted.' }
      format.json { head :no_content }
    end
  end

  def checkname
    @user = User.search(params[:name])
    respond_to do |format|
      format.json {render json: {name_exists: @user.present?}}
  end
end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    accessible = [:name, :email, :role]
    accessible << [:password, :password_confirmation] unless
      params[:user][:password].blank?
    params.require(:user).permit(accessible)
  end
end
