Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'pokemon/:id' => 'pokemon#show'

  # get '*a', :to => 'pokemon#routing'
  get 'pokemon/*a', to: 'application#not_found'


end
