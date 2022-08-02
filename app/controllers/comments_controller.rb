# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: %i[create]
  before_action :set_comment, :authorize_comment, only: %i[destroy]

  after_action :verify_authorized, only: %i[destroy]

  def create
    @comment = @product.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to product_path(@product)
    else
      flash[:error] = 'Comment is not valid.'
    end
  end

  def edit; end

  def update; end

  def destroy
    @product = @comment.product
    if @comment.destroy
      redirect_to product_path(@product)
    else
      flash[:error] = 'There is some error in deleting comment.'
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def authorize_comment
    authorize @comment
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
