Gaku::Core::Engine.routes.draw do

  # concerns

  concern :addresses do
    resources :addresses, concerns: %i( soft_delete primary ), except: %i( show index soft )
  end

  concern :contacts do
    resources :contacts, concerns: %i( soft_delete primary )
  end

  concern :notes do
    resources :notes
  end

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

  # devise
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
    post :create_admin,        to: 'devise/registrations#create_admin'
  end

  resources :extracurricular_activities, concerns: %i( student_chooser pagination soft_delete show_deleted ) do
    resources :students,
      controller: 'extracurricular_activities/students',
      concerns: %i( enroll_student )
  end

  resources :class_groups, concerns: %i( notes soft_delete student_chooser ) do
    resources :semester_class_groups, controller: 'class_groups/semester_class_groups'
    resources :class_group_course_enrollments, controller: 'class_groups/courses'
    resources :students, controller: 'class_groups/students', concerns: %i( enroll_student )
  end

  resources :courses, concerns: %i( notes student_chooser soft_delete show_deleted ) do
    resources :semester_courses, controller: 'courses/semester_courses'
    resources :enrollments, controller: 'courses/enrollments', concerns: %i( enroll_student ) do
      post :enroll_class_group, on: :collection
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
  end

  resources :class_group_enrollments,              concerns: %i( enroll_students )
  resources :course_enrollments,                   concerns: %i( enroll_students )
  resources :extracurricular_activity_enrollments, concerns: %i( enroll_students )

  resources :syllabuses, concerns: %i( notes soft_delete show_deleted ) do
    resources :assignments,     controller: 'syllabuses/assignments'
    resources :exams,           controller: 'syllabuses/exams'
    resources :exam_syllabuses, controller: 'syllabuses/exam_syllabuses'
  end

  resources :teachers, concerns: %i( addresses contacts notes soft_delete show_deleted pagination )

  resources :students, concerns: %i( addresses contacts notes soft_delete show_deleted pagination ) do
    get :load_autocomplete_data, on: :collection

    resources :simple_grades,        controller: 'students/simple_grades', except: :show
    resources :commute_methods,      controller: 'students/commute_methods'
    resources :student_achievements, controller: 'students/student_achievements', except: :show
    resources :student_specialties,  controller: 'students/student_specialties',  except: :show

    resources :guardians, except: %i( index show ),
      controller: 'students/guardians',
      concerns: %i( addresses contacts soft_delete )

    resources :course_enrollments,
      controller: 'students/course_enrollments',
      only: %i( new create destroy )

    resources :class_group_enrollments, controller: 'students/class_group_enrollments'
  end

  resources :exams, concerns: %i( notes soft_delete ) do
    put :create_exam_portion, on: :member

    resources :exam_scores
    resources :exam_portions, controller: 'exams/exam_portions', concerns: %i( sort ) do
      resources :attachments, controller: 'exams/exam_portions/attachments'
    end
  end

  resources :states, only: :index
  resources :attachments, concerns: %i( soft_delete download )

  resources :course_groups, concerns: %i( soft_delete ) do
    resources :course_group_enrollments, controller: 'course_groups/course_group_enrollments'
  end

  root to: 'home#index'


  # admin

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
      resources :campuses, controller: 'schools/campuses', except: :index,  concerns: %i( contacts ) do
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
    resources :templates, concerns: %i( download )
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
      resources :semesters, controller: 'school_years/semesters'
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
