Rails.application.routes.draw do
  root 'pages#home'

  get 'posts(/:slug)', to: 'blog_posts#show', as: :blog_post

  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'
end
