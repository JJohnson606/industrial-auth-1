class CommentPolicy < ApplicationPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def show?
   
    user == current_user ||
    !@comment.user.private? || 
   @comment.photo.owner.followers.include?(@user)
  end

  def create?
    !@user.nil? 
  end

  def update?
    @user == @comment.author # Only allow the user who created the comment to update it
  end

  def destroy?
    @user == @comment.author # Only allow the user who created the comment to delete it
  end
end
