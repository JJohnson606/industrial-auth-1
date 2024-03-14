class FollowRequestPolicy < ApplicationPolicy
  attr_reader :user, :follow_request

  def initialize(user, follow_request)
    @user = user
    @follow_request = follow_request
  end
  
  def create?
  true 
  end

  def show?
   follow_request.sender == user  || follow_request.recipient == user
  end

  def update?
    follow_request.sender == user || follow_request.recipient == user 
  end

  def destroy?
    follow_request.sender == user || follow_request.recipient == user 
  end

end
