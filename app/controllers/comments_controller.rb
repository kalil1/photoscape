class CommentsController < ApplicationController
  before_action :find_picture
  before_action :find_comment, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit]

  def new
    @comment = Comment.new(picture_id: params[:picture_id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.picture_id = @picture.id
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to picture_path(@picture)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to picture_path(@picture)
    else
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    redirect_to picture_path(@picture)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

  def find_picture
    @picture = Picture.find(params[:picture_id])
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

end
