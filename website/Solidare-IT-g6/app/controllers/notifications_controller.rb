class NotificationsController < ApplicationController
  
  def index
    if user_signed_in?
      @notifications = Notification.where("notified_user == :user_id", :user_id => current_user.id)
      @users = User.all
    else
      dont_see
    end
  end
  
end
