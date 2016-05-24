class Admin::ProfilesController < ApplicationController
	before_action :check_if_admin, only: [:index]
	before_action :authenticate_user!

	def index
		@profiles = Profile.all
	end
end
