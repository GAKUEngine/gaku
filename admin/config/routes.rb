Gaku::Core::Engine.add_routes  do

  concern :soft_delete do
    patch :recovery,    on: :member
    patch :soft_delete, on: :member
  end

  concern(:primary)         { patch :make_primary, on: :member }
  concern(:show_deleted)    { get :show_deleted, on: :member }
  concern(:pagination)      { get 'page/:page', action: :index, on: :collection }
  concern(:sort)            { post :sort, on: :collection }
  concern(:download)        { get :download, on: :member }
  concern(:enroll_students) { post :enroll_students, on: :collection }
  concern(:enroll_student)  { post :enroll_student, on: :collection }
  concern(:student_chooser) { get :student_chooser, on: :member }

  #root to: :achievements

  namespace :admin do

    get 'school_details',          to: 'schools#show_master'
    get 'school_details/edit',     to: 'schools#edit_master'
    patch 'school_details/update', to: 'schools#update_master'

    resources :schools do
      resources :programs, controller: 'schools/programs' do
        member do
          get :show_program_levels
          get :show_program_syllabuses
          get :show_program_specialties
        end
      end
      resources :campuses, controller: 'schools/campuses', except: :index do
        resources :contacts, concerns: %i( soft_delete primary )

        resources :addresses, controller: 'schools/campuses/addresses', except: %i( show index )
      end
    end

    resources :achievements
    resources :specialties
    resources :system_tools
    resources :commute_method_types
    resources :contact_types
    resources :enrollment_statuses
    resources :attendance_types
    resources :departments
    resources :users, concerns: %i( pagination )
    resources :roles
    resources :templates, except: %i( show ), concerns: %i( download )
    resources :grading_methods
    resources :grading_method_sets, concerns: %i( primary ) do
      resources :grading_method_set_items,
        controller: 'grading_method_sets/grading_method_set_items',
        concerns: %i( sort )
    end

    resources :states do
      post :country_states, on: :collection
    end

    resources :school_years do
      resources :semesters, controller: 'school_years/semesters', except: %i( show index )
    end

    namespace :changes do
      resources :students, controller: 'student_changes', concerns: %i( pagination )
      resources :student_contacts,  controller: 'student_contact_changes'
      resources :student_addresses, controller: 'student_address_changes'
    end

    resources :presets

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

        get 'students/page/:page',      action: :students
        get 'teachers/page/:page',      action: :teachers
        get 'guardians/page/:page',     action: :guardians
        get 'exams/page/:page',         action: :exams
        get 'course_groups/page/:page', action: :course_groups
        get 'attachments/page/:page',   action: :attachments
        get 'addresses/page/:page',     action: :addresses
        get 'contacts/page/:page',      action: :contacts
      end
    end

  end
end
