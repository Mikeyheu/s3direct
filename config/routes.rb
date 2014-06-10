S3direct::Application.routes.draw do
  resources :images do
  	collection do
  		post :check_processed
  	end
  end
end
