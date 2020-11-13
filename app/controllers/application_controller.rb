class ApplicationController < ActionController::Base
	before_action :store_user_location!, if: :storable_location?
	before_action :authenticate_user!

  include Pundit

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

protected
before_action :configure_permitted_parameters, if: :devise_controller?

def configure_permitted_parameters
  added_attrs = [:nickname, :email, :password, :address]
  devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :address])
end
  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
	end

	def storable_location?
		request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
	end

	def store_user_location!
		# :user is the scope we are authenticating
		store_location_for(:user, request.fullpath)
	end
end
