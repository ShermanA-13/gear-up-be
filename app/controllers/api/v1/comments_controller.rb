class Api::V1::CommentsController < ApplicationController
  before_action :set_user, only: [:create]
  before_action :set_trip, only: [:create]

  def create
    comment = Comment.new(comment_params)
    comment.update(trip: @trip, user: @user)
    if comment.save
      render json: {success: "Comment Created"}, status: :created
    end
  end

  def destroy
    Comment.destroy(params[:comment_id])
    render json: {success: "Comment Deleted"}
  end

  private
    def comment_params
      params.require(:comment).permit(:message)
    end
end
