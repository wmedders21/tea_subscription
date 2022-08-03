Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers do
        get '/teas', to: 'tea_customers#index'
        post '/teas', to: 'tea_customers#create'
        patch '/teas/:id', to: 'tea_customers#update'
      end
    end
  end
end
