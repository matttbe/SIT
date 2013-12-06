class NotificationsController < ApplicationController
  before_action :clean_db, only: [:index]
  
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
  
  #private
  def clean_db
    @notifications = Notification.where(:notified_user => current_user.id)
    if ! @notifications.nil?
      @notifications.each do |notif|
         time = notif.created_at + 10*86400
         #If notification has been done more than 10 days ago, remove it
         if time < DateTime.now
           notif.destroy
         end
      end
    end
  end
  
end
