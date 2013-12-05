class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :my_services , :update, :destroy]

   # GET /user/:user_id/services
  def my_services
    if user_signed_in?
      @services = current_user.own_services.order(:is_demand)
	  @pending_services = Service.joins(:accept_services).where(accept_services: {user_id: current_user.id,is_chosen_customer: false})
	  @accepted_services = Service.joins(:accept_services).where(accept_services: {user_id: current_user.id,is_chosen_customer: true})
    else
      dont_see
    end
  end
  
  def show
    protect_param_integer
    if @can
     @user = User.find(params[:user_id])
     @services = Service.where("creator_id = :user_id", :user_id => @user.id)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:user_id])
      @following = Follower.where("user_id = :user_id", :user_id => @user.id)   
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :firstname, :birthdate, :email, :karma, :id_ok, :presentation, :inscription_ok, :superuser)
    end
    
end
