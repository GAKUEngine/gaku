Gaku::Core::Engine.routes.draw do

  concern :soft_delete do
    patch :recovery,    on: :member
    patch :soft_delete, on: :member
  end

  concern :addresses do
    resources :addresses, concerns: %i( soft_delete primary ), except: %i( show index )
  end

  concern :contacts do
    resources :contacts, concerns: %i( soft_delete primary )
  end

  concern :notes do
    resources :notes
  end

  concern(:primary)         { patch :make_primary, on: :member }
  concern(:show_deleted)    { get :show_deleted, on: :member }
  concern(:pagination)      { get 'page/:page', action: :index, on: :collection }
  concern(:sort)            { post :sort, on: :collection }
  concern(:download)        { get :download, on: :member }
  concern(:enroll_students) { post :enroll_students, on: :collection }
  concern(:enroll_student)  { post :enroll_student, on: :collection }
  concern(:student_chooser) { get :student_chooser, on: :member }


  devise_scope :user do
    get :set_up_admin_account, to: 'devise/registrations#set_up_admin_account'
    post :create_admin,        to: 'devise/registrations#create_admin'
  end

  resources :extracurricular_activities, concerns: %i( student_chooser pagination ) do
    resources :students,
      controller: 'extracurricular_activities/students',
      concerns: %i( enroll_student )
  end

  resources :class_groups, concerns: %i( notes student_chooser pagination ) do
    collection do
      get :search
      get :search_semester
      get :advanced_search
      get :semester_advanced_search
      get :with_semester
      get :without_semester
    end
    resources :semester_class_groups, controller: 'class_groups/semester_class_groups'
    resources :class_group_course_enrollments, controller: 'class_groups/courses', only: %i( new create destroy )
    resources :students, controller: 'class_groups/students', only: %i( new destroy ), concerns: %i( enroll_student )
  end

  resources :courses, concerns: %i( notes student_chooser ) do
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

  resources :syllabuses, concerns: %i( notes ) do
    resources :assignments,     controller: 'syllabuses/assignments'
    resources :exams,           controller: 'syllabuses/exams'
    resources :exam_syllabuses, controller: 'syllabuses/exam_syllabuses'
  end

  resources :teachers, concerns: %i( addresses contacts notes show_deleted pagination )

  resources :students, concerns: %i( addresses contacts notes pagination ) do
    get :search, on: :collection
    get :advanced_search, on: :collection
    get :chosen, on: :collection
    resources :simple_grades,        controller: 'students/simple_grades', except: :show
    resources :commute_methods,      controller: 'students/commute_methods'
    resources :badges, controller: 'students/badges', except: :show
    resources :student_specialties,  controller: 'students/student_specialties',  except: :show
    resources :external_school_records,  controller: 'students/external_school_records',  except: :show

    resources :guardians, except: %i( index show ),
      controller: 'students/guardians',
      concerns: %i( addresses contacts )

    resources :course_enrollments,
      controller: 'students/course_enrollments',
      only: %i( new create destroy )

    resources :class_group_enrollments, controller: 'students/class_group_enrollments'
  end

  resources :exams, concerns: %i( notes pagination ) do
    put :create_exam_portion, on: :member

    resources :exam_scores
    resources :exam_portions, controller: 'exams/exam_portions', concerns: %i( sort ) do
      resources :attachments, controller: 'exams/exam_portions/attachments'
    end
  end

  resources :attachments, concerns: %i( download )

  resources :course_groups  do
    resources :course_group_enrollments, controller: 'course_groups/course_group_enrollments'
  end

  resources :search, only: :index do
    collection do
      get :students
    end
  end


end
