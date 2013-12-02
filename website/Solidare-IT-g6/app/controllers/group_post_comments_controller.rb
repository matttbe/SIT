class GroupPostCommentsController < ApplicationController

  def create
    @group_post = GroupPost.find(params[:group_post_id])
    @group_post_comment = @group_post.group_post_comments.create(params[:group_post_comment].permit(:body))
	@group_post_comment.user_id=current_user.id
	@group_post_comment.save
	@group_post.touch

	@group = Group.find(GroupPost.find(params[:group_post_id]).group_id)
    redirect_to group_path(@group)
  end

end
