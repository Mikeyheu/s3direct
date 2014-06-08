# AWS initialization config

AWS.config(access_key_id:  ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'], region: 'us-west-2')
sqs = AWS::SQS.new
SQS_QUEUE = sqs.queues.named('basic_queue')
