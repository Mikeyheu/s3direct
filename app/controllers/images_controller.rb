class ImagesController < ApplicationController
  def index
  	@images = Image.all
  end

  def create
  	@image = Image.new(image_params)

  	respond_to do |format|
      if @image.save
        format.json { 
          data = { image_id: @image.id }
          render json: data
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

  def check_processed
    images = Image.where(id:params[:file_ids], image_processed: true)
    image_ids = []
    image_urls = []
    images.each_with_index do |image|
      image_ids << image.id
      image_urls << image.image_thumb
    end
    puts image_ids

    respond_to do |format|
      format.json { render json: { image_ids: image_ids, image_urls: image_urls } }
    end
  end

end