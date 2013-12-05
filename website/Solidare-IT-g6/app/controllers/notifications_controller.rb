class NotificationsController < ApplicationController
  
  def index
    if user_signed_in?
      @notifications = Notification.where(:notified_user => current_user.id)
      @notifications.each do |notif|
        if notif.seen == false
          notif.seen = true
          notif.save
        end
      end
      @users = User.all
    else
      dont_see
    end
  end
end
