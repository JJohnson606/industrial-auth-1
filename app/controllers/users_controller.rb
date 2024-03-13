class UsersController < ApplicationController
  before_action :set_user, only: %i[show liked feed followers following discover]
  before_action :authorize_user, only: [:show, :edit, :feed, :liked, :discover, :update]

  def show  
  end
  
  def edit
     
  end

  def feed
  end
  
  def discover
  end

  def liked
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end
  
private

    def set_user
      if params[:username]
        @user = User.find_by!(username: params.fetch(:username))
      else
        @user = current_user
      end
    end

    def authorize_user
      authorize @user
    end

end
