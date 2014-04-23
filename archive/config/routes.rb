Gaku::Core::Engine.routes.draw  do

  concern(:pagination)      { get 'page/:page', action: :index, on: :collection }
  concern :soft_delete do
    patch :recovery,    on: :member
    patch :soft_delete, on: :member
  end

  resources :attachments, concerns: :soft_delete
  resources :teachers, concerns: :soft_delete
  resources :students, concerns: :soft_delete do
    get :search, on: :collection
    get :clear_search, on: :collection
    get :advanced_search, on: :collection
    get :chosen, on: :collection
    resources :guardians, concerns: :soft_delete
  end

  resources :student_selection, only: :index do
    collection do
      get :clear
      post :add
      post :remove
    end
  end

  resources :extracurricular_activities, concerns: :soft_delete
  resources :class_groups, concerns: :soft_delete do
    collection do
      get :search
      get :search_semester
      get :advanced_search
      get :semester_advanced_search
      get :with_semester
      get :without_semester
    end
  end
  resources :courses, concerns: :soft_delete
  resources :course_groups, concerns: :soft_delete
  resources :exams, concerns: :soft_delete
  resources :syllabuses, concerns: :soft_delete

  namespace :admin do

    resources :students, only: :show

    namespace :changes do
      resources :students, controller: 'student_changes', concerns: %i( pagination )
      resources :student_contacts,  controller: 'student_contact_changes'
      resources :student_addresses, controller: 'student_address_changes'
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
