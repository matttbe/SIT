class GroupPostsController < ApplicationController

  def create
    @group = Group.find(params[:group_id])
    @group_post = @group.group_posts.create(params[:group_post].permit(:body))
	@group_post.user_id=current_user.id
	@group_post.save
    redirect_to group_path(@group)
  end


end
