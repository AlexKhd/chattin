require 'rails_helper'
require 'faker'

RSpec.describe UsersController, type: :controller do
  include Devise::TestHelpers

  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to User, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    { email: Faker::Internet.email,
      password: Faker::Internet.password(6, 9),
      name: Faker::Internet.name,
      confirmed_at: Time.now
     }
  end

  let(:invalid_attributes) do
    { user:
      {
        email: Faker::Lorem.characters(10),
        password: Faker::Internet.password(10, 19)
      }
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # UsersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @user = FactoryGirl.create :user, :confirmed
    sign_in @user
  end

  xdescribe 'GET #index' do
    it 'assigns all users in index' do
      get :index
      expect(assigns(:users)).to eq(User.all)
    end

    it 'returns all of the users' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do
    it 'assigns the requested user as @user' do
      user = User.create! valid_attributes
      get :show, { id: user.to_param }, valid_session
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'GET #new' do
    it 'assigns a new user as @user' do
      get :new, {}, valid_session
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested user as @user' do
      user = User.create! valid_attributes
      get :edit, { id: user.to_param }, valid_session
      expect(assigns(:user)).to eq(user)
    end
  end

  xdescribe 'POST #create' do
    context 'with valid params' do
      it 'creates a new User' do
        expect { post :create, valid_attributes }.to change(User, :count).by(1)
      end

      it 'assigns a newly created user as @user' do
        post :create, { user: valid_attributes }, valid_session
        expect(assigns(:user)).to be_a(User)
        # expect(assigns(:user)).to be_persisted
      end

      it 'redirects to the created user' do
        post :create, { user: valid_attributes }, valid_session
        # expect(response).to redirect_to(User.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved user as @user' do
        post :create, { user: invalid_attributes }, valid_session
        expect(assigns(:user)).to be_a_new(User)
      end

      it "re-renders the 'new' template" do
        post :create, { user: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          email: 'admin@admin.com',
          password: 'password'
        }
      end

      it 'updates the requested user' do
        user = User.create! valid_attributes
        put :update, { id: user.to_param, user: new_attributes }, valid_session
        user.reload
        skip('Add assertions for updated state')
      end

      it 'assigns the requested user as @user' do
        user = User.create! valid_attributes
        put :update, id: user.to_param, user: valid_attributes
        expect(assigns(:user)).to eq(user)
      end

      it 'redirects to the user' do
        user = User.create! valid_attributes
        put :update, id: user.to_param, user: valid_attributes
        expect(response).to redirect_to(user)
      end
    end

    context 'with invalid params' do
      it 'assigns the user as @user' do
        user = User.create! valid_attributes
        put :update, id: user.to_param, user: invalid_attributes
        expect(assigns(:user)).to eq(user)
      end

      it "re-renders the 'edit' template" do
        user = User.create! valid_attributes
        put :update, id: user.to_param, user: invalid_attributes
        # expect(response).to render_template("edit")
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested user' do
      user = User.create! valid_attributes
      delete :destroy, { id: user.to_param }, valid_session
      expect(User.find_by(id: user.id)).to be_nil
    end

    it 'redirects to the users list' do
      user = User.create! valid_attributes
      delete :destroy, { id: user.to_param }, valid_session
      expect(response).to redirect_to(users_url)
    end
  end
end
