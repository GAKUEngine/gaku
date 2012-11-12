Gaku::Core::Engine.routes.prepend do
	namespace :admin do 
		resources :admissions
    resources :admission_methods do
      resources :admission_phases, :controller => 'admission_methods/admission_phases' do
        member do
          get :show_phase_states
        end
      end
    end
    resources :admission_periods do
      member do
        get :show_methods
      end
    end
	end

end