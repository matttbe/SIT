class GroupPostsController < ApplicationController

  def create
    @group = Group.find(params[:group_id])
    @group_post = @group.group_posts.create(params[:group_post].permit(:body))
  	@group_post.user_id=current_user.id
  	@group_post.save
  	
    create_group_notif(@group, 'POST')
    
    redirect_to group_path(@group)
  end

  def destroy
	@group_post = GroupPost.find(params[:id])
	@group_post.destroy
	@comments = GroupPostComment.where(group_post_id: params[:id])
	@comments.each do |comment|
		comment.destroy
	redirect_to group_path(params[:group_id])
	end
  end

end
