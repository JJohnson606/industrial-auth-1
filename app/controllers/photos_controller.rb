class PhotosController < ApplicationController
  before_action :set_photo, only: %i[show edit update destroy]
  before_action :authorize_photo, only: [:show, :new, :create, :edit, :update, :destroy]

  def index
    @photos = policy_scope(Photo)
    @photos = Photo.all
  end

  def show
  end

  def new
    @photo = Photo.new
  end

  def edit
  end

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      redirect_to @photo, notice: "Photo was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    
    if @photo.update(photo_params)
      redirect_to @photo, notice: "Photo was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @photo.destroy
    redirect_back fallback_location: root_url, notice: "Photo was successfully destroyed."
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def authorize_photo
    authorize @photo
  end

  def photo_params
    params.require(:photo).permit(:image, :caption)
  end
end
