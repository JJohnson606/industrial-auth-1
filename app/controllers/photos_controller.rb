class PhotosController < ApplicationController
  before_action :set_photo, only: %i[show edit update destroy]
  before_action :authorize_photo, only: [:show, :edit, :update, :destroy]

  def index
    @photos = policy_scope(Photo)
  end

  def show
  end

  def new
  @photo = Photo.new
  authorize Photo
  end

  def edit
  end

  def create
   @photo = Photo.new(photo_params)
   @photo.owner = current_user
   authorize @photo
   
    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: "Photo was successfully created." }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
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
