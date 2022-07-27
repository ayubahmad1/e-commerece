class CommentsController < ApplicationController
  after_action :verify_authorized, only: %i[destroy]

  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_to product_path(@product)
  end

  def edit
    # @comment = Comment.find(params[:id])
    # @product = Product.find(params[:product_id])
  end

  def update

  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment
    @product = @comment.product
    @comment.destroy
    redirect_to product_path(@product)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
