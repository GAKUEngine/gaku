Gaku::Core::Engine.routes.prepend do
	namespace :admin do 
		resources :admissions do
      collection do
        post :change_admission_period
        post :change_admission_method
        post :change_student_state
      end
    end
    resources :admission_methods do
      resources :admission_phases, :controller => 'admission_methods/admission_phases' do
        resources :admission_phase_states, :controller => 'admission_methods/admission_phases/admission_phase_states' do
          post :make_default, :on => :member
        end
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