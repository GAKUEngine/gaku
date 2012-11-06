Gaku::Core::Engine.routes.prepend do
	namespace :admin do 
		resources :admissions
	end

end