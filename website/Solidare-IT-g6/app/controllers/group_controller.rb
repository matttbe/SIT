class GroupController < ApplicationController

  def new
  end

  def show
	@group = Group.find(params[:id])
  end

  def create
	@group = Group.new(group_params)
 
    @group.save
    redirect_to @group
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
 
    redirect_to group_index_path
  end

  private
    def group_params
      params.require(:group).permit(:name, :description)
    end

end
