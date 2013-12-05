class Users::RegistrationsController < Devise::RegistrationsController
  def create
    @user = build_resource
    super
  end

  def update
    @user = resource
    super
  end
end
