Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers do
        post '/teas', to: 'tea_customers#create'
      end
    end
  end
end
