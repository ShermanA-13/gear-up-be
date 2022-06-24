class Api::V1::CommentsController < ApplicationController
  before_action :set_user, only: [:create]
  before_action :set_trip, only: [:create, :destroy]

  def create
    comment = Comment.new(comment_params)
    comment.update(trip: @trip, user: @user)
    if comment.save
      render json: {success: "Comment Created"}, status: :created
    end
  end

  def destroy
    if Comment.exists?(params[:comment_id])
      Comment.destroy(params[:comment_id])
      render json: {success: "Comment Deleted"}
    else
      error = Error.new(404, "NOT FOUND", "No comment with id #{params[:comment_id]}")
      not_found_error(error)
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:message)
    end
end
