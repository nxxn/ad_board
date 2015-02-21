class RegistrationsController < Devise::RegistrationsController

  def create
    if verify_recaptcha
      super
    else
      build_resource(sign_up_params)
      clean_up_passwords(resource)
      flash[:error] = "There was an error with the recaptcha code below. Please re-enter the code." 
      flash.delete :recaptcha_error
      ap flash
      render :new
    end
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
