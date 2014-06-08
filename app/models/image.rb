class Image < ActiveRecord::Base
  
  after_save :send_to_sqs
  
  private

  def send_to_sqs
  	JobQueue.queue.send_message({image_id: id, image_url:image_url}.to_json)
  end

	# after_save send message to sqs
  # background worker polls sqs, pulls message and proceeds to process image
  # save the processed images to s3 using uploads/sites/site_id/images/image_id/filename_size.jpg
  # update database with new urls
  # worker updates the image_processed attribute to true when completed 
end
