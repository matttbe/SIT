class GroupController < ApplicationController
  before_action :is_logged_in, only: [:new,:create, :update, :destroy]

  def new
  end

  def show
	@group = Group.find(params[:id])
  end

 # GET /user/groups
  def my_groups
    if user_signed_in?
      @groups = Group.joins(:group_user_relations).where(group_user_relations: {user_id: current_user.id})
    else
      dont_see
    end
  end

  def create
	@group = Group.new(group_params)

	respond_to do |format|
  	  if @group.save
	    @relation = GroupUserRelation.new(:user_id => current_user.id, :group_id => @group.id)
	    if @relation.save
		  format.html { redirect_to @group, notice: 'Group was successfully created.' }
          format.json { render action: 'show', status: :created, location: @group }
		else
		  show_error(format,'new',@relation)
		end
	  else
		show_error(format,'new',@group)
	  end
    end
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
      params.require(:group).permit(:name, :description, :private, :secret, :photo)
    end

    def is_logged_in
        if !user_signed_in?
            dont_see
        end
    end

end
