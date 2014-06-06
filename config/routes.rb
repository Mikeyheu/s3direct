S3direct::Application.routes.draw do
  resources :images do
    collection do
      get :s3form
    end
  end
end
