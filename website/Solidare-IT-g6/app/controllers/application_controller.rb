class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :can_log_in
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :firstname
    devise_parameter_sanitizer.for(:sign_up) << :birthdate
  end

    def can_log_in
      
    if defined?(params) && !params['user'].nil?
      @u = User.find_by_email(params['user']['email'])
      if !@u.nil? &&!@u.id_ok
        #format.html { redirect_to root_path, alert: 'You must first validated' }
        redirect_to root_path, alert: "A admin must first accept you.  Be patient !"
      end
    end
  end
end
