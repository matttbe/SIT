class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :can_log_in
  after_filter :store_location

  # https://github.com/plataformatec/devise/wiki/How-To:-Redirect-back-to-current-page-after-sign-in,-sign-out,-sign-up,-update
  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    if (request.fullpath != "/users/sign_in" &&
        request.fullpath != "/users/sign_up" &&
        request.fullpath != "/users/sign_out" &&
        request.fullpath != "/sign_in" &&
        request.fullpath != "/users" &&
        request.fullpath != "/create_account" &&
        request.fullpath != "/users/password" &&
        request.fullpath != "/users/password/new" &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end
  
  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def give_badge_transaction(transaction)
    @user=User.find(transaction.user_id)
    @u=User.order(:karma).last
    if @user.karma>@u.karma
      add_unique_badge(@user,8)
      @u.remove_badge(8)
    end
    case
      when @user.karma>0
        add_unique_badge(@user,2)#@user.add_badge(2) unless User.find(@user.id).badges.any?{|badge| badge.id=2}
      when @user.karma>5
        add_unique_badge(@user,3)#@user.add_badge(3) unless User.find(@user.id).badges.any?{|badge| badge.id=3}
      when @user.karma>10
        add_unique_badge(@user,4)#@user.add_badge(4) unless User.find(@user.id).badges.any?{|badge| badge.id=4}
      when @user.karma>25
        add_unique_badge(@user,5)#@user.add_badge(5) unless User.find(@user.id).badges.any?{|badge| badge.id=5}
      when @user.karma>50
        add_unique_badge(@user,6)#@user.add_badge(6) unless User.find(@user.id).badges.any?{|badge| badge.id=6}
    end
    

  end
  
  def notif_email(user, notification, object)
    if user.mail_notif      
      Notifier.send_notif(user, notification, object).deliver
    end
  end
  
  def create_badge_notif(badge, user)
    @badge = Merit::Badge.find(badge)
    @notification = nil
    @notifications_list = Notification.where("badge = :badge_id AND notified_user = :user_id", :badge_id =>badge, :user_id => user)
    if @notifications_list.size > 0
      @notifications_list.each do |notif|
        if notif.notification_type == "BADGE_"+@badge.name
          @notification = notif
        else
          @notification = Notification.new
        end
      end
    else
      @notification = Notification.new
    end
    @notification.notified_user = user
    @notification.notification_type = "BADGE_"+@badge.name
    @notification.creator_id = user.id 
    @notification.seen = false
    @notification.save
    notif_email(user, @notification, "New Badge")
  end
  
  def create_group_notif(group, type)
    group.users.each do |user|      
      if user.id != current_user.id
        @notifications_list = Notification.where("group_id = :group_id AND notified_user = :user_id", :group_id => group, :user_id => user)
        @notification = nil
        if @notifications_list.size > 0
          @notifications_list.each do |notif|
            if notif.notification_type == type
              @notification = notif
            else
              @notification = Notification.new
            end 
          end
        else
        @notification = Notification.new
        end
        if user.managed_org_id > 0
          @notification.notified_user = user.coworker_org_id
        else
          @notification.notified_user = user.id
        end
        @notification.group = group
        @notification.notification_type = type
        @notification.creator_id = current_user.id 
        @notification.seen = false
        notif_email(user,@notification, "Group Notification")
        if ! @notification.save
            show_error(format,'new',@notification)
        end
      end
    end
  end
  
  def create_notification(service, type, user_notified_id)
    @notifications_list = Notification.where("service_id = :service_id AND notified_user = :user_id", :service_id => service.id, :user_id => user_notified_id)
    @user = User.where(:id => user_notified_id).first
    @notification = nil
    if @notifications_list.size > 0
      @notifications_list.each do |notif|
        if (type == 'FOLLOW' and notif.notification_type == 'UNFOLLOW') or (type == 'UNFOLLOW' and notif.notification_type == 'FOLLOW') or (notif.notification_type == type) 
          @notification = notif
        else
          @notification = Notification.new
        end
      end
    else
      @notification = Notification.new
    end
    if @user.managed_org_id > 0
      @notification.notified_user = @user.coworker_org_id
    else
      @notification.notified_user = @user.id
    end
    @notification.service = service 
    @notification.notification_type = type
    @notification.creator_id = current_user.id 
    @notification.seen = false
    notif_email(@user, @notification, "Service Notification")
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

  def get_child_categories
    cats = get_categories_from_node_id(params[:id], true)

    render json: cats
  end

  def get_categories_from_node_id(cat_id, withChild)
    cat = Category.find(cat_id)
    return get_categories_from_node(cat, withChild)
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

  # for ActiveAdmin & Canca
  def access_denied(exception)
    redirect_to root_path, :alert => exception.message
  end

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
        redirect_to root_path, alert: "An administrator has to activate your new account, please be patient."
        # "You received an email from us. Please activate your account"
    end
  end

  def add_unique_badge(user,id)
    @do= User.find(user.id).badges.any?{|badge| badge.id=id}
    if @do
      @user.add_badge(id)
      create_badge_notif(id, user)
    end
    
  end
end
