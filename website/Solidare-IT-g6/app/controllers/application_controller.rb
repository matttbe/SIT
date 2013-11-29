class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :can_log_in

  def dont_see
    respond_to do |format|
          format.html { redirect_to "/sign_in", alert: 'You need to sign in or sign up before continuing.' }
    end
  end

  def protect_param_integer
    @can=true
    if defined?(params[:id])&&!params[:id].nil?&& (params[:id]=="all")
      @can=false
      logger.debug(params[:id])
      logger.debug("===================================")
      respond_to do |format|
        format.html { redirect_to '/', alert: 'You can not do that !' }
      end
    end
  end

  def show_error(format,actionName,model)
    format.html { render action: actionName }
    format.json { render json: model.errors, status: :unprocessable_entity }
  end

  def generateLink(search,param)
    link=search
    if search.nil?
      link="/search?q="+param
    elsif search.include?(param)
      link=search.gsub(param, "")
    elsif
      link=search+param
    end
    return link
  end

  helper_method :generateLink
  
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

  # protected?
  def authenticate_active_admin_user!
    authenticate_user!
    unless current_user.has_role? "superadmin"
      flash[:alert] = "Unauthorized Access!"
      redirect_to root_path
    end
  end

end
