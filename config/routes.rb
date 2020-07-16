Rails.application.routes.draw do
  post "likes/:post_id/create" =>"likes#create"
  post "likes/:post_id/destroy" =>"likes#destroy"

  
  get 'users/index'
  get "users/new"=>"users#new"
  post "users/create"=>"users#create"
  get "users/login_form"=>"users#login_form"
  get "users/:id/likes"=>"users#likes"
  get "users/:id/edit"=>"users#edit"
  
  post "users/:id/update"=>"users#update"
  get "users/:id"=>"users#show"
  post "logout"=>"users#logout"
  post "login"=>"users#login"


  get "posts/new"=>"posts#new"
  post "posts/create"=>"posts#create"
  get "posts/:reply_id/reply_new"=>"posts#reply_new"
  post "posts/:reply_id/reply_create"=>"posts#reply_create"
  get 'posts/index'
  get "posts/enjoydecks"=>"posts#enjoydecks"
  get "posts/masterdecks"=>"posts#masterdecks"
  get "posts/cupinformation"=>"posts#cupinformation"
  get "posts/friends"=>"posts#friends"
  get "posts/playing"=>"posts#playing"
  get "posts/:id/edit"=>"posts#edit"
  get "posts/:id"=>"posts#show"
  post "posts/:id/update"=>"posts#update"
  post "posts/:id/destroy"=>"posts#destroy"
  
  
  
  


  get "/"=>"home#top"
  get "about"=>"home#about"






  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
