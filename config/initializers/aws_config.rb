# AWS initialization config
AWS.config({
	access_key_id:  ENV['AWS_ACCESS_KEY_ID'], 
	secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'], 
	region: 'us-west-2'
})

module JobQueue
	def self.queue
		@queue ||= AWS::SQS.new.queues.named(ENV['SQS_QUEUE_NAME'])
	end
end

