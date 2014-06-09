task :poll => :environment do
  JobQueue.queue.poll do |msg| 
    puts JSON.parse(msg.body) 
    # background worker polls sqs, pulls message and proceeds to process image
    # save the processed images to s3 
    # update database with new urls
    # worker updates the image_processed attribute to true when completed 
  end
end