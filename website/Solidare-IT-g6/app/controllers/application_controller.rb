class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def dont_see
    respond_to do |format|
          format.html { redirect_to root_path, alert: 'You don\'t have the autorisation to see this page !' }
    end
  end


end
