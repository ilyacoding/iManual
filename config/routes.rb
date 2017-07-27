Rails.application.routes.draw do
  resources :blocks

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :manuals, :steps, :blocks
  resources :markdowns, controller: 'blocks', type: 'markdown'
  resources :videos, controller: 'blocks', type: 'video'
  resources :images, controller: 'blocks', type: 'image'


  scope '/api' do
    resources :manuals, :steps, :blocks, :defaults => { :format => 'json' }
    resources :markdowns, controller: 'blocks', type: 'Markdown', :defaults => { :format => 'json' }
    resources :videos, controller: 'blocks', type: 'Video', :defaults => { :format => 'json' }
    resources :images, controller: 'blocks', type: 'Image', :defaults => { :format => 'json' }
  end

  root to: 'manuals#index'
end
