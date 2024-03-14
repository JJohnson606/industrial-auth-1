class PhotoPolicy < ApplicationPolicy
  attr_reader :user, :photo

  def initialize(user, photo)
    @user = user
    @photo = photo
  end

def show?
  @user == @photo.owner ||
    !@photo.owner.private? ||
    @photo.owner.followers.include?(@user)
end


def new?
  create?
 end
 
 def create?
   !@user.nil?
 end
 

def update?
@user == @photo.owner
end

def edit?
  update?
end

# def photo_comment_create?
#   @photo.owner.comment
# end

def photo_comment_edit?
   @photo.owner.comment
end

def photo_comment_destroy?
   @photo.owner.comment
end

def destroy?
@user == @photo.owner
end

class Scope < Scope
    def resolve
      if @user == @photo.owner ||
    !@photo.owner.private? ||
    @photo.owner.followers.include?(@user)
        scope.all  
      else
        scope.where(public: true)  # Regular users only see public photos
      end
    end
  end
end
