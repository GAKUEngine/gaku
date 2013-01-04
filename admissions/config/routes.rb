Gaku::Core::Engine.routes.prepend do
	namespace :admin do
		resources :admissions do
      collection do
        post :change_admission_period
        post :change_admission_method
        post :change_student_state
        get :student_chooser
        post :create_multiple
        post :admit_student
      end

      get :new_applicant
    end

    resources :admission_phases do
      resources :exams do
        get :grading, :on => :member
        resources :exam_portion_scores do
          resources :attendances
        end
      end
    end

    resources :admission_methods do
      resources :admission_phases, :controller => 'admission_methods/admission_phases' do
        post :sort, :on => :collection
        resources :admission_phase_states, :controller => 'admission_methods/admission_phases/admission_phase_states' do
          post :make_default, :on => :member
        end
        resources :exams, :controller => 'admission_methods/admission_phases/exams' do
          get :exciting, :on => :member
          post :assign_exciting, :on => :collection
          delete :destroy_connection, :on => :member
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