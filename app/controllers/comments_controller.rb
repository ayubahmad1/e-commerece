# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: %i[new create]
  before_action :set_comment, :authorize_comment, only: %i[destroy edit update]

  after_action :verify_authorized, only: %i[destroy]

  def new
    @comment = @product.comments.new
  end

  def create
    @comment = @product.comments.build(comment_params)
    if @comment.save
      redirect_to product_path(@product)
    else
      flash[:alert] = 'Comment is not valid.'
    end
  end

  def edit
    respond_to do |format|
      format.html { redirect_to edit_comment_path }
      format.js
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to product_path(@comment.product)
    else
      render 'edit'
    end
  end

  def destroy
    @product = @comment.product
    if @comment.destroy
      redirect_to product_path(@product)
    else
      flash[:alert] = 'There is some error in deleting comment.'
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
    params.require(:comment).permit(:body).merge(user_id: current_user.id)
  end
end
