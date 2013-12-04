class GroupController < ApplicationController
  before_action :is_logged_in, only: [:new,:create, :member?, :update, :destroy]

  def new
  end

  def show
	@group = Group.find(params[:id])
  end

  def create
	@group = Group.new(group_params)

  @group.save

	@relation = GroupUserRelation.new(:user_id => current_user.id, :group_id => @group.id)
	@relation.save

    redirect_to @group
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
 
    redirect_to group_index_path
  end

  def index
    @groups = Group.all
    render 
  end

  def add_user

  end  
  
  def member?
    logger.debug("+++++++++++ I TAKE THIS METHOD ++++++++++++++")
    @group = Group.find(params[:id])
    @group.users.each do |member|
      if member.id == current_user.id
        return true
      end
    end
    return false
  end

  private
    def group_params
      params.require(:group).permit(:name, :description, :private, :secret, :photo)
    end

    def is_logged_in
        if !user_signed_in?
            dont_see
        end
    end

end
