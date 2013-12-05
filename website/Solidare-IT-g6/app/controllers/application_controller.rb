class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :can_log_in

  def can_manage_orga
  end

  def give_badge_transaction(transaction)
    @user=User.find(transaction.user_id)
    case
    when @user.karma>0
      @user.add_badge(2)
    when @user.karma>5
      @user.add_badge(3)
    when @user.karma>10
      @user.add_badge(4)
    end
  end
  
  def create_group_notif(group, type)
    logger.debug("+++++++++++++++ CREATE NOTIF +++++++++++++++++++++++++++++")
    group.users.each do |user|
      logger.debug("+++++++++++++++ A USER +++++++++++++++++++++++++++++")
      @notifications_list = Notification.where("group_id = :group_id AND notified_user = :user_id", :group_id => group, :user_id => user)
      @notification = nil
      if @notifications_list.size > 0
        @notifications_list.each do |notif|
          if notif.notification_type == type
            @notification = notif
          else
            @notification = Notification.new
            @notification.notified_user = user.id
            @notification.group = group
          end 
        end
      else
      @notification = Notification.new
      @notification.notified_user = user.id
      @notification.group = group
      end
    end
    @notification.notification_type = type
    @notification.creator_id = current_user.id 
    @notification.seen = false
    if ! @notification.save
        show_error(format,'new',@notification)
    end
  end
  
  def create_notification(service, type, user_notified_id)
    @notifications_list = Notification.where("service_id = :service_id AND notified_user = :user_id", :service_id => service.id, :user_id => user_notified_id)
    @notification = nil
    if @notifications_list.size > 0
      @notifications_list.each do |notif|
        if (type == 'FOLLOW' and notif.notification_type == 'UNFOLLOW') or (type == 'UNFOLLOW' and notif.notification_type == 'FOLLOW') or (notif.notification_type == type) 
          @notification = notif
        else
          @notification = Notification.new
          @notification.notified_user = user_notified_id
          @notification.service = service          
        end
      end
    else
      @notification = Notification.new
      @notification.notified_user = user_notified_id
      @notification.service = service
    end
    @notification.notification_type = type
    @notification.creator_id = current_user.id 
    @notification.seen = false
    if ! @notification.save
        show_error(format,'new',@notification)
    end
  end
  
  def notify(service, type)
    @followers_list = Follower.where("service_id = :service_id", :service_id => service.id)
    @followers_list.each do |follower|
      create_notification(service, type, follower.user_id)
    end
  end

  def notify_owner(service, type)
    create_notification(service, type, service.creator_id)
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

  def get_categories_from_node(category, withChild)
    cats = Array.new
    category.childs.each do |child|
      cats << child
      if withChild
        childs = get_categories_from_node(child, withChild)
        if not childs.empty?
          cats << childs
        end
      end
    end
    cats
  end

  def get_categories_from_node_id(cat_id, withChild)
    cat = Category.find(cat_id)
    get_categories_from_node(cat, withChild)
  end

  def get_all_categories_from_root(withChild)
    cats = Array.new
    Category.all.each do |cat|
      if cat.parent_cat.nil?
        cats << cat
        if withChild
          childs = get_categories_from_node(cat, withChild)
          if not childs.empty?
            cats << childs
          end
        end
      end
    end
    cats
  end

  def get_all_categories
    get_all_categories_from_root(true)
  end

  def get_all_root_categories
    get_all_categories_from_root(false)
  end

  helper_method :generateLink, :get_all_categories, :get_all_root_categories, :get_categories_from_node, :get_categories_from_node_id

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :firstname
    devise_parameter_sanitizer.for(:sign_up) << :birthdate
    devise_parameter_sanitizer.for(:sign_up) << :avatar
    devise_parameter_sanitizer.for(:sign_up) << :mail_notif

    devise_parameter_sanitizer.for(:account_update) << :name
    devise_parameter_sanitizer.for(:account_update) << :firstname
    devise_parameter_sanitizer.for(:account_update) << :birthdate
    devise_parameter_sanitizer.for(:account_update) << :avatar
    devise_parameter_sanitizer.for(:account_update) << :mail_notif
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

  def add_unique_badge(user,id)
    
  end

  def authenticate_active_admin_user!
    authenticate_user!
    unless current_user.has_role? "superadmin"
      flash[:alert] = "Unauthorized Access!"
      redirect_to root_path
    end
  end
end
