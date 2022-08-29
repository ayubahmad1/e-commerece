# frozen_string_literal: true
module Api
  class CommentsController < ApplicationController
    def show
      comment = Comment.find(params[:id]);
      render json: {status: 'SUCCESS', message: 'Loaded Comment', data: comment }, status: :ok
    end
  end
end
