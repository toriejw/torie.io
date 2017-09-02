Rails.application.routes.draw do
  root 'pages#home'

  resources :blog_posts, only: :show

  get '/about', to: 'pages#about'
end
