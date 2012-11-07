Gaku::Core::Engine.routes.prepend do
	namespace :admin do 
		resources :admissions
    resources :admission_methods do
      resources :admission_phases, :controller => 'admission_methods/admission_phases'
    end
	end

end