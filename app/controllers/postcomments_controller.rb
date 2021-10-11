class PostcommentsController < InheritedResources::Base

  def create
    # @postcomment.user_id = current_user.id
    @post = Post.find(params[:post_id])
    @postcomment = @post.postcomments.create(postcomment_params.merge(user_id: current_user.id))
    # redirect_to post_path(@post)
    redirect_to posts_path
  end


private

  def postcomment_params
    params.require(:postcomment).permit(:content, :user_id, :post_id)
  end

end
