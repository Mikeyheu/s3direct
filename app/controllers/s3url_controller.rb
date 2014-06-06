class s3urlController < ApplicationController

	def index
		render json: {
			policy: 's3 policy here',
			signature: 's3 signature here',
			key: 'key here',
			success_action_redirect: 'not sure what this is for'
		}
	end

end