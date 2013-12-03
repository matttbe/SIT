class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :can_log_in

  def can_manage_orga
  end

  def dont_see
    respond_to do |format|
          format.html { redirect_to "/sign_in", alert: 'You need to sign in or sign up before continuing.' }
    end
  end

  def can_do_that
    respond_to do |format|
          format.html { redirect_to root_path, alert: 'You can not do that !' }
    end
  end

  def protect_param_integer
    @can=true
    if defined?(params[:id])&&!params[:id].nil?&& (params[:id]=="all")
      @can=false
      redirect_to root_path, alert: 'You can not do that !'
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

  def getAllCategoriesChilds(category)
    cats = Array.new
    category.childs.each do |child|
      cats << child
      childs = getAllCategoriesChilds(child)
      if not childs.empty?
        cats << childs
      end
    end
    cats
  end

  def getAllCategoriesRootOrChilds(withChild)
    cats = Array.new
    Category.all.each do |cat|
      if cat.parent.nil?
        cats << cat
        if withChild
          childs = getAllCategoriesChilds(cat)
          if not childs.empty?
            cats << childs
          end
        end
      end
    end
    cats
  end

  def getAllCategories
    getAllCategoriesRootOrChilds(true)
  end

  def getAllRootCategories
    getAllCategoriesRootOrChilds(false)
  end

  helper_method :generateLink, :getAllCategories, :getAllCategoriesChilds, :getAllRootCategories

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :firstname
    devise_parameter_sanitizer.for(:sign_up) << :birthdate
    devise_parameter_sanitizer.for(:sign_up) << :avatar

    devise_parameter_sanitizer.for(:account_update) << :name
    devise_parameter_sanitizer.for(:account_update) << :firstname
    devise_parameter_sanitizer.for(:account_update) << :birthdate
    devise_parameter_sanitizer.for(:account_update) << :avatar
  end

  def can_log_in
    @redirect=false
    if defined?(params) && !params['user'].nil?
      @u = User.find_by_email(params['user']['email'])
      @redirect=true
    elsif defined?(current_user) && !current_user.nil?
      @u = current_user
      @redirect=true
    end

    if @redirect&&!@u.nil? &&!@u.id_ok
        sign_out @u
        redirect_to root_path, alert: "A admin must first accept you.  Be patient !"
    end
  end

  def authenticate_active_admin_user!
    authenticate_user!
    unless current_user.has_role? "superadmin"
      flash[:alert] = "Unauthorized Access!"
      redirect_to root_path
    end
  end
end
