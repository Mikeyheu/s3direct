task :poll => :environment do
  JobQueue.queue.poll do |msg| 
    
    # S3 setup and configuration
    s3 = AWS::S3.new
    bucket_name = ENV['AWS_S3_BUCKET']
    s3_upload_path = "uploads/site_id/whatever/"
    
    # get image data from SQS message (image_id + image_url)
    image_data = JSON.parse(msg.body) 
    image_id = image_data.image_id
    image_url = image_data.image_url

    # open file with Imagemagick
    image = MiniMagick::Image.open(image_url)

    # resize file
    image.resize "200x200"

    # generate thumb name
    thumbname = File.basename(image_data.image_url, ".*") + "_thumb.jpg"
    
    # save the processed images to s3 
    s3.buckets[bucket_name].objects[s3_upload_path + thumbname].write(Pathname.new(image.path), :acl => :public_read)

    # confirmation of successful upload???
    # update database with new urls
    # update the image_processed attribute to true when completed 
  end
end