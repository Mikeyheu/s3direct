S3direct::Application.routes.draw do
  resources :images 
  resources :s3url, only: [:index]
end
