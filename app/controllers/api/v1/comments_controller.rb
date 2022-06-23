class Api::V1::CommentsController < ApplicationController

  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: {success: "Comment Created"}, status: :created
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:trip_id, :user_id, :message)
    end
end
