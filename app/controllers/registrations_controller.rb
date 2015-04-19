class RegistrationsController < Devise::RegistrationsController

  def create
    #if verify_recaptcha
    if true
      super
    else
      build_resource(sign_up_params)
      clean_up_passwords(resource)
      flash[:error] = "There was an error with the recaptcha code below. Please re-enter the code."
      flash.delete :recaptcha_error
      render :new
    end
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    if params[:user][:current_password].present? && params[:user][:password].present? && params[:user][:password_confirmation].present?
      if resource.valid_password?(params[:user][:current_password]) && params[:user][:password] == params[:user][:password_confirmation]
        resource.password = params[:user][:password]
      else
        flash[:error] = "Password do not match"
        resource_updated = false
      end
    end

    resource_updated = update_resource(resource, account_update_params)

    if params[:user][:current_email].present? && params[:user][:new_email].present?
      if params[:user][:current_email] == resource.email
        resource.email = params[:user][:new_email]
      else
        flash[:error] = "Email do not match"
        resource_updated = false
      end
    end

    yield resource if block_given?
    if resource_updated && flash.empty?
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      if flash[:error] == "Password do not match"
        redirect_to edit_user_registration_path(password: "true")
      elsif flash[:error] == "Email do not match"
        redirect_to edit_user_registration_path(email: "true")
      else
        render :edit
      end
    end
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_update_path_for(resource)
    user_path(resource.id)
  end
end
