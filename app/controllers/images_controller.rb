class ImagesController < ApplicationController
  def index
  	@images = Image.all
  end

  def create
  	@image = Image.new(image_params)

  	respond_to do |format|
      if @image.save
        # defer all these to background process???
        # send message to sqs with image id and original image url for image processing
        SQS_QUEUE.send_message({image_id: @image.id, image_url:@image.image_url}.to_json)


        # image_processed attribute is set to default value of false when image is created
        # need to add some more image attributes for various sizes
        # background worker polls sqs, pulls message and proceeds to process image
        # save the processed images to s3 using uploads/sites/site_id/images/image_id/filename_size.jpg
        # update database with new urls
        # worker updates the image_processed attribute to true when completed 
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
end