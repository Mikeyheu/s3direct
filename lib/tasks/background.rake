task :poll => :environment do
  JobQueue.queue.poll do |msg| 
    
    # S3 setup and configuration
    s3 = AWS::S3.new
    bucket_name = ENV['AWS_S3_BUCKET']
    s3_upload_path = "uploads/s3direct/"
    
    # get image data from SQS message (image_id + image_url)
    msg_body = JSON.parse(msg.body) 
    image_id = msg_body["image_id"]
    image_url = msg_body["image_url"]

    # # open file with Imagemagick
    image_to_resize = MiniMagick::Image.open(image_url)

    # # resize file
    image_to_resize.resize "200x200"

    # # generate thumb name
    thumbname = File.basename(image_url, ".*") + "_thumb.jpg"
    
    # # save the processed images to s3 
    s3.buckets[bucket_name].objects[s3_upload_path + thumbname].write(Pathname.new(image_to_resize.path), :acl => :public_read)
    
    # confirmation of successful upload???
    # update database with new urls

    thumb_url = "https://#{bucket_name}.s3.amazonaws.com/#{s3_upload_path}#{thumbname}"

    image = Image.find(image_id)

    if image
      image.update_attribute("image_thumb", thumb_url)
    else
      puts "could not find ID"
    end
    # update the image_processed attribute to true when completed 
  end
end