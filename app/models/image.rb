class Image < ActiveRecord::Base
  
  after_commit :send_to_sqs
  
  private

  def send_to_sqs
  	JobQueue.queue.send_message({image_id: id, image_url:image_url}.to_json)
  end

end
