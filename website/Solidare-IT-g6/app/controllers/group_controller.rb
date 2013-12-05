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
	    @relation = GroupUserRelation.new(:user_id => current_user.id, :group_id => @group.id, :role => 'Admin')
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

  def edit
	@group = Group.find(params[:id])
	@basic_users = User.joins(:group_user_relations).where(group_user_relations: {group_id: params[:id],role:"basic"})
  end


  def update
    @group = Group.find(params[:id])
 
    if @group.update(params[:group].permit(:name, :description, :private, :secret, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at))
      redirect_to @group
    else
      render 'edit'
    end
  end


  def destroy
    #TODO verifier que l'utilisateur est admin du groupe    
    @group = Group.find(params[:id])
    @notifications = Notification.where("group_id = :group_id", :group_id => @group.id)
    @notifications.each do |notif|
      notif.destroy
    end
    @group.destroy
    redirect_to group_index_path
  end

  def index
    @groups = Group.all
    render 
  end

  def delete_user
	@to_destroy = GroupUserRelation.where(user_id: params[:u_id],group_id: params[:g_id])
	@to_destroy.each do |t_d|
	  GroupUserRelation.destroy(t_d.id)
	end
	redirect_to edit_group_path(Group.find(params[:g_id]))
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
