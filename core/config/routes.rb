Gaku::Core::Engine.routes.draw do

  mount Sidekiq::Web => '/sidekiq'

  devise_for :users, {
    class_name: 'Gaku::User',
    module: :devise,
     controllers: {
       sessions: 'gaku/devise/sessions',
       registrations: 'gaku/devise/registrations',
       passwords: 'gaku/devise/passwords'
     }
  }

  devise_scope :user do
    get :set_up_admin_account, to: 'devise/registrations#set_up_admin_account'
    post :create_admin, to: 'devise/registrations#create_admin'
  end

  resources :extracurricular_activities do
    member do
      get :student_chooser
    end

    resources :students, controller: 'extracurricular_activities/students' do
      collection do
        post :enroll_student
      end
    end
  end

  resources :class_groups do
    member do
      get :student_chooser
    end
    resources :semester_class_groups, controller: 'class_groups/semester_class_groups'
    resources :class_group_course_enrollments, controller: 'class_groups/courses'
    resources :notes

    resources :students, controller: 'class_groups/students' do
      collection do
        post :enroll_student
      end
    end
  end


  resources :courses do
    resources :semester_courses, controller: 'courses/semester_courses'
    resources :notes
    resources :enrollments, controller: 'courses/enrollments' do
      post :enroll_class_group, on: :collection
      post :enroll_student, on: :collection
    end

    resources :exams do
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
    member do
      get :student_chooser
    end
  end


  resources :class_group_enrollments do
    collection do
      post :enroll_students
    end
  end


  resources :course_enrollments do
    collection do
      post :enroll_students
    end
  end


  resources :extracurricular_activity_enrollments do
    collection do
      post :enroll_students
    end
  end


  #resources :exam_portion_scores

  resources :syllabuses do
    resources :assignments, controller: 'syllabuses/assignments'
    resources :exams, controller: 'syllabuses/exams'
    resources :exam_syllabuses, controller: 'syllabuses/exam_syllabuses'
    resources :notes
    resources :importer, controller: 'syllabuses/importer'
  end

  resources :teachers do
    get 'page/:page', action: :index, on: :collection
    member do
      get :soft_delete
      get :recovery
      get :show_deleted
    end

    resources :notes

    resources :contacts do
      member do
        post :make_primary
        get :soft_delete
        get :recovery
      end
    end

    resources :addresses do
      member do
        post :make_primary
        get :soft_delete
        get :recovery
      end
    end
  end

  resources :students do

    member do
      get :edit_enrollment_status
      put :enrollment_status
      get :recovery
      get :soft_delete
      get :show_deleted
    end

    collection do
      get 'page/:page', action: :index
      get :autocomplete_search
      get :load_autocomplete_data

      resources :importer, controller: 'students/importer' do
        collection do
          get :get_roster
          get :get_registration_roster
        end
      end
    end

    resources :simple_grades, controller: 'students/simple_grades'
    resources :commute_methods, controller: 'students/commute_methods'
    resources :student_achievements, controller: 'students/student_achievements'
    resources :student_specialties, controller: 'students/student_specialties'

    #resources :enrollment_statuses, controller: 'students/enrollment_statuses' do
      #resources :notes, controller: 'students/enrollment_statuses/notes'
    #  member do
    #    get :history
    #    get :revert
    #  end
    #end


    resources :guardians, controller: 'students/guardians' do
      member do
        get :soft_delete
        get :recovery
      end

      resources :contacts do
        post :create_modal, on: :collection
        member do
          post :make_primary
          get :soft_delete
          get :recovery
        end
      end

      resources :addresses do
        member do
          post :make_primary
          get :soft_delete
          get :recovery
        end
      end
    end

    resources :contacts do
      member do
        post :make_primary
        get :soft_delete
        get :recovery
      end
    end

    resources :addresses do
      member do
        post :make_primary
        get :soft_delete
        get :recovery
      end
    end

    resources :notes
    resources :course_enrollments, controller: 'students/course_enrollments'
    resources :class_group_enrollments, controller: 'students/class_group_enrollments'
    #resources :exams
    #resources :courses

  end

  resources :exams do
    member do
      put :create_exam_portion
      delete :soft_delete
      get :recovery
    end

    resources :notes
    resources :exam_scores
    resources :exam_portions, controller: 'exams/exam_portions' do
      post :sort, on: :collection
      resources :attachments, controller: 'exams/exam_portions/attachments'
    end
  end

  resources :states

  resources :course_groups do
    resources :course_group_enrollments, controller: 'course_groups/course_group_enrollments'
    member do
      delete :soft_delete
      get :recovery
    end
  end

  root to: 'home#index'


  scope path: :admin, as: :admin do
    resources :schools, controller: 'admin/schools' do
      resources :programs, controller: 'admin/schools/programs' do
        member do
          get :show_program_levels
          get :show_program_syllabuses
          get :show_program_specialties
        end
      end
      resources :campuses, controller: 'admin/schools/campuses' do
        resources :contacts do
          post :make_primary, on: :member
        end
        resources :addresses, controller: 'admin/schools/campuses/addresses'
      end
    end
  end

  namespace :admin do
    resources :achievements
    resources :specialties
    resources :system_tools
    resources :commute_method_types
    resources :contact_types
    resources :enrollment_statuses
    resources :attendance_types
    resources :users do
      get 'page/:page', action: :index, on: :collection
    end
    resources :roles
    resources :templates do
      get :download, on: :member
    end
    resources :grading_methods
    resources :grading_method_sets do
      post :make_primary, on: :member
      resources :grading_method_set_items, controller: 'grading_method_sets/grading_method_set_items' do
        post :sort, on: :collection
      end
    end
    resources :states do
      post :country_states, on: :collection
    end

    resources :school_years do
      resources :semesters, controller: 'school_years/semesters'
    end


    namespace :changes do
      resources :students, controller: 'student_changes' do
        get 'page/:page', action: :index, on: :collection
      end
      resources :student_contacts, controller: 'student_contact_changes'
      resources :student_addresses, controller: 'student_address_changes'
    end

    resources :presets do
      collection do
        get :students
        get :locale
        get :grading
        get :pagination
        get :defaults
        get :output_formats
        get :names

        put :update_presets
      end
    end

    resources :disposals do
      collection do
        get :students
        get :teachers
        get :guardians
        get :exams
        get :course_groups
        get :attachments
        get :addresses
        get :contacts

        get 'students/page/:page', action: :students
        get 'teachers/page/:page', action: :teachers
        get 'guardians/page/:page', action: :guardians
        get 'exams/page/:page', action: :exams
        get 'course_groups/page/:page', action: :course_groups
        get 'attachments/page/:page', action: :attachments
        get 'addresses/page/:page', action: :addresses
        get 'contacts/page/:page', action: :contacts
      end
    end

    match 'school_details' => 'schools#school_details', via: :get
    match 'school_details/edit' => 'schools#edit_master', via: :get

  end

  resources :attachments do
    member do
      get :download
      delete :soft_delete
      get :recovery
    end
  end

end
