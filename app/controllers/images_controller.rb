class ImagesController < ApplicationController
  def index
  	@images = Image.all
  end

  def create
  	@image = Image.new(image_params)

  	respond_to do |format|
      if @image.save
        format.html { redirect_to images_path }
        format.json { 
          # data = { image_id: @image.id }
          # render json: data
          render json: @image
        }
      else
        format.html { render :index }
        format.json { render json: @image.errors }
      end
    end
  end


  def image_params
  	params.require(:image).permit(:image_file)
  end
end