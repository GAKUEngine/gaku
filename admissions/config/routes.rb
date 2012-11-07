Gaku::Core::Engine.routes.prepend do
	namespace :admin do 
		resources :admissions
    resources :admission_methods
	end

end