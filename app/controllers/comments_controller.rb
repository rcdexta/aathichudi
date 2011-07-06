class CommentsController < ApplicationController

  def new
    render :new, :layout => false
  end

  def create
    comment = Comment.new
    comment.name = params[:comment][:name]
    comment.email = params[:comment][:email]
    comment.comment = params[:comment][:comment]
    Thread.new do
      CommentNotifier.send_mail(comment).deliver
    end
    render :nothing => true
  end
end
