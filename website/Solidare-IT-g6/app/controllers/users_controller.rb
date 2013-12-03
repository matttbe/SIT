class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
    protect_param_integer
    if @can
     @user = User.find(params[:id])
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      #COMMENT CREATING ERROR
      @user = User.find(params[:id])      
      @following = Follower.where("user_id = :user_id", :user_id => current_user.id)   
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :firstname, :birthdate, :email, :karma, :id_ok, :presentation, :inscription_ok, :superuser)
    end
    
end
