class RegistrationsController < Devise::RegistrationsController
	protected

	def after_sign_up_path_for(resource)
		vinyls_path
	end
end

def after_sign_in_path_for(resource_or_scope)
  stored_location_for(resource_or_scope) || super
end
