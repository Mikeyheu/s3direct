# AWS initialization config
AWS.config({
	access_key_id:  ENV['AWS_ACCESS_KEY_ID'], 
	secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'], 
	region: 'us-west-2'
})

# Note - may need to adjust before and after forks on unicorn
# http://stackoverflow.com/questions/21075781/redis-global-variable-with-ruby-on-rails

module JobQueue
	def self.queue
		@queue ||= AWS::SQS.new.queues.named(ENV['SQS_QUEUE_NAME'])
	end
end

