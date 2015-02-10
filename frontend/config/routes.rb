Gaku::Core::Engine.routes.draw do

  concern :soft_delete do
    patch :recovery,    on: :member
    patch :soft_delete, on: :member
  end

  concern :addresses do
    resources :addresses, concerns: %i( soft_delete primary ), except: %i( show )
  end

  concern :contacts do
    resources :contacts, concerns: %i( soft_delete primary )
  end

  concern :notes do
    resources :notes
  end

  concern :semesterable do
    resources :semester_connectors
  end

  concern :gradable do
    resources :grading_method_connectors, only: %i( new create destroy index ), concerns: %i( sort ) do
      collection do
        get :new_set
        post :add_set
      end
    end
  end

  concern :enrollmentable do
    resources :enrollments do
      collection do
        get :student_selection
        post :create_from_selection
      end
    end
  end

  concern(:primary)         { patch :make_primary, on: :member }
  concern(:pagination)      { get 'page/:page', action: :index, on: :collection }
  concern(:sort)            { post :sort, on: :collection }
  concern(:download)        { get :download, on: :member }
  concern(:student_selection) { get :student_selection, on: :member }
  concern(:set_picture) do
    member do
      patch :set_picture
      delete :remove_picture
    end
  end

  devise_scope :user do
    get :set_up_admin_account, to: 'devise/registrations#set_up_admin_account'
    post :create_admin,        to: 'devise/registrations#create_admin'
  end

  resources :extracurricular_activities, concerns: %i( pagination enrollmentable )

  resources :class_groups, concerns: %i( notes student_selection pagination semesterable) do
    collection do
      get :search
      get :search_semester
      get :advanced_search
      get :semester_advanced_search
      get :with_semester
      get :without_semester
    end

    resources :semester_attendances, controller: 'class_groups/semester_attendances'

    resources :enrollments, controller: 'class_groups/enrollments', concerns: :sort do
      collection do
        get :student_selection
        post :create_from_selection
      end
    end

    resources :student_reviews, controller: 'class_groups/student_reviews'
  end

  resources :courses, concerns: %i( notes gradable enrollmentable semesterable ) do

    resources :exams, controller: 'courses/exams' do
      resources :exam_portion_scores do
        resources :attendances
      end

      collection do
        get :grading
        get :export
      end

      member do
        get :grading
        put :update_score
        get :completed
      end
    end
  end

  resources :syllabuses, concerns: %i( notes ) do
    resources :assignments,     controller: 'syllabuses/assignments'
    resources :exams,           controller: 'syllabuses/exams'
    resources :exam_syllabuses, controller: 'syllabuses/exam_syllabuses'
  end

  resources :teachers, concerns: %i( addresses contacts notes pagination set_picture )

  resources :student_selection, only: :index do
    collection do
      get :clear
      post :add
      post :remove
      post :collection
      post :remove_collection
    end
  end

  resources :guardians, only: [], concerns: %i( addresses contacts set_picture )

  resources :students, concerns: %i( addresses contacts notes pagination set_picture ) do
    get :search, on: :collection
    get :clear_search, on: :collection
    get :advanced_search, on: :collection
    get :chosen, on: :collection
    resources :simple_grades,        controller: 'students/simple_grades', except: :show
    resources :commute_methods,      controller: 'students/commute_methods'
    resources :badges, controller: 'students/badges', except: :show
    resources :student_specialties,  controller: 'students/student_specialties',  except: :show
    resources :external_school_records,  controller: 'students/external_school_records',  except: :show

    resources :guardians, except: %i( show )

    with_options only: %i( index new create destroy ) do |enrollment|
      enrollment.resources :class_group_enrollments, controller: 'students/class_group_enrollments'
      enrollment.resources :course_enrollments, controller: 'students/course_enrollments'
      enrollment.resources :extracurricular_activity_enrollments, controller: 'students/extracurricular_activity_enrollments'
    end

    resources :reports, only: :index, controller: 'students/reports'

  end

  resources :exam_sessions, controller: 'exams/exam_sessions', except: :index

  resources :exams, concerns: %i( notes pagination gradable ) do
    put :create_exam_portion, on: :member

    resources :exam_scores
    resources :exam_portions, controller: 'exams/exam_portions', concerns: %i( sort ) do
      resources :attachments, concerns: %i( download soft_delete )
    end
  end

  resources :attachments, only: :destroy,  concerns: %i( soft_delete )

  resources :course_groups  do
    resources :course_group_enrollments, controller: 'course_groups/course_group_enrollments'
  end

  resources :search, only: :index do
    collection do
      get :students
    end
  end

  get 'realtime/exam_portion_scores', to: 'realtime#exam_portion_scores'

end
