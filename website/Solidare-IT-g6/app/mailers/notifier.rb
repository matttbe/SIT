class Notifier < ActionMailer::Base
  default from: "solidare.it.6@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.admin_validated.subject
  #
  def admin_validated(user)
    @user=user
    mail to: user.email, :subject=>"Your account is validated"
  end

  def send_notif(user, notification, subject)
    @user=user
    @notification=notification
    mail to: user.email, :subject=>subject
  end
  
  def new_badge(user, badge, subject)
    @user=user
    @badge=badge
    mail to: user.email, :subject=>subject
  end

  def user_to_validate(user)
    @user = user
    mail to: @user.email, :subject=>"SolidareIT: Please validate your account"
  end
end
