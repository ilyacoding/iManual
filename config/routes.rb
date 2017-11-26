Rails.application.routes.draw do

  resources :completed_steps
  resources :completed_manuals
  post '/rate' => 'rater#create', :as => 'rate'
  mount ActionCable.server => '/cable'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :manuals do
    resources :comments
    resources :steps
  end

  resources :searches, :tags, only: [:index]
  resources :categories
  resources :blocks, :users

  resources :textes, controller: 'blocks', type: 'Text'
  resources :videos, controller: 'blocks', type: 'Video'
  resources :images, controller: 'blocks', type: 'Image'

  root to: 'manuals#index'
end
