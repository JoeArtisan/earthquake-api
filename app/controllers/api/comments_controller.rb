module Api
  class CommentsController < ApplicationController

    def index
      feature = Feature.find(params[:feature_id])
      comments = feature.comments

      formatted_comments = comments.map do |comment|
        {
          id: comment.id,
          body: comment.body,
          created_at: comment.formatted_created_at,
        }
      end

      render json: {
        data: formatted_comments
      }
    end

    def create
      feature = Feature.find(params[:feature_id])
      comment = feature.comments.build(comment_params)

      if comment.save
        render json: comment, status: :created
      else
        render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private
    def comment_params
      params.require(:comment).permit(:body)
    end
  end
end