Gaku::Core::Engine.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'authenticate', to: 'authentication#authenticate'
      post 'authenticate/refresh', to: 'authentication#refresh'
      resources :students
    end
  end
end
