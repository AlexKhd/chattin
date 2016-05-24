class ProfilesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_profile, only: [:show]

	def show
		@profile.update_attribute(:rating, 0) unless @profile.rating
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

	def set_profile
		@profile = Profile.find(params[:id])
	end
end
