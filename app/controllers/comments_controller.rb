# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!, except: %i[index create destroy]
  before_action :set_product, only: %i[index new create]
  before_action :set_comment, only: %i[destroy edit update]

  # after_action :verify_authorized, only: %i[destroy]

  def index
    @comments = @product.comments
    render json: {status: 'SUCCESS', message: 'Loaded Comments', data: @comments }, status: :ok
  end

  def new
    @comment = @product.comments.new
  end

  def create
    @comment = @product.comments.build(comment_params)
    if @comment.save
      render json: {status: 'SUCCESS', message: 'Comment Saved', data: @comment }, status: :ok
    else
      render json: {status: 'ERROR', message: 'Comment Not Saved', data: @comment.errors }, status: :unprocessable_entity
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
      # redirect_to product_path(@product)
      render json: {status: 'SUCCESS', message: 'Comment Deleted', data: @comment }, status: :ok
    else
      # flash[:alert] = 'There is some error in deleting comment.'
      render json: {status: 'ERROR', message: 'Comment Not Deleted', data: @comment.errors }, status: :unprocessable_entity
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
    # params.require(:comment).permit(:body).merge(user_id: current_user.id)
    params.require(:comment).permit(:body).merge(user_id: 6)
  end
end
