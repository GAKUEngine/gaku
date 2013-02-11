Gaku::Core::Engine.routes.prepend do
	namespace :admin do
		resources :admissions do
      collection do
        get :change_admission_period
        get :change_admission_method
        get  :change_period_method
        post :change_student_state
        get :student_chooser
        post :create_multiple
        post :admit_students
        get :listing_admissions
        get :listing_applicants
        resources :importer, :controller => "admissions/importer" do
          collection do
            post :import_sheet
          end
        end
      end
      member do
        delete :soft_delete
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
          get :existing, :on => :collection
          post :assign_existing, :on => :collection
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

    resources :students
	end
end
