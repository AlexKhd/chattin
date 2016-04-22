class ProfilesController < ApplicationController
	before_filter :authenticate_user!

	def index
		@profiles = Profile.all
	end

	def show
		if current_user.present?
			@profile = Profile.find(params[:id])
		else
  		@profile = Profile.find(params[:id])
  		@profiles = Profile.where('id != ?', current_user.id)
  	end
	end

	def new
		@profile = Profile.new
	end

	def create

  end

  def edit

  end

	def update

	end

  private

  def profile_params

  end
end
