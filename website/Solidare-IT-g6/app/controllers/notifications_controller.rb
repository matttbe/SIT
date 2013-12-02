class NotificationsController < ApplicationController
  
  def show
    if user_signed_in?
      @notifications = Notification.where( "notified_user == :user_id", :user_id => current_user.id)
    else
      dont_see
    end
  end
  
  def index
    if user_signed_in?
      @notifications = Notification.where("notified_user == :user_id", :user_id => current_user.id)
    else
      dont_see
    end
  end
  
end
