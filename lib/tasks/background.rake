task :poll => :environment do
  JobQueue.queue.poll(:visibility_timeout => 20) do |msg| 
    # get image data from SQS message (image_id + image_url)
    msg_body = JSON.parse(msg.body) 
    puts "msg body:"
    puts msg_body
    image_id = msg_body["image_id"]
    image_url = msg_body["image_url"]
    
    image = Image.find(image_id)
    if image.image_thumb == nil

      # S3 setup and configuration
      s3 = AWS::S3.new
      bucket_name = ENV['AWS_S3_BUCKET']
      s3_upload_path = "uploads/s3direct/"
      
      # open file with Imagemagick
      image_to_resize = MiniMagick::Image.open(image_url)

      # resize file
      image_to_resize.resize "200x200"

      # generate thumb name
      thumbname = File.basename(image_url, ".*") + "_thumb.jpg"
      
      # save the processed images to s3 
      s3.buckets[bucket_name].objects[s3_upload_path + thumbname].write(Pathname.new(image_to_resize.path), :acl => :public_read)
      # confirmation of successful upload???
      # update database with new urls
      # some issue with messages not being removed from the queue - too long???
      
      thumb_url = "https://#{bucket_name}.s3.amazonaws.com/#{s3_upload_path}#{thumbname}"
      
      image.update_attributes(image_thumb:thumb_url, image_processed: true)
      puts "finished processing, uploading and updating"
    end

  end
end