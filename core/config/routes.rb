Gaku::Core::Engine.routes.draw do

  devise_for :users,  class_name: 'Gaku::User', module: :devise,
                      controllers: { sessions: 'gaku/devise/sessions',
                                     registrations: 'gaku/devise/registrations',
                                     passwords: 'gaku/devise/passwords'
                                    }

  resources :states, only: :index

  root to: 'home#index'
end
