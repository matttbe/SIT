class GroupController < ApplicationController

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

  private
    def group_params
      params.require(:group).permit(:name, :description, :private, :secret)
    end

end
