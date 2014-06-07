class ImagesController < ApplicationController
  def index
  	@images = Image.all
  end

  def create
    puts "hit create controller"
  	@image = Image.new(image_params)

  	respond_to do |format|
      if @image.save
        format.json { 
          # data = { image_id: @image.id }
          # render json: data
          render json: @image
        }
      else
        format.json { render json: @image.errors }
      end
    end
  end

  def show
    puts "hit show controller"
  end


  def image_params
  	params.require(:image).permit(:image_url)
  end
end