Gaku::Core::Engine.add_routes  do



  devise_for :users, {
    class_name: 'Gaku::User',
    module: :devise,
    controllers: {
       sessions: 'gaku/devise/sessions',
       registrations: 'gaku/devise/registrations',
       passwords: 'gaku/devise/passwords'
     }
  }

end
