Lesstalkymoreshippy::Application.routes.draw do
  resources :targets

  resources :projects

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end