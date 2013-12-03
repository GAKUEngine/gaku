Gaku::Core::Engine.add_routes  do

  concern(:pagination)      { get 'page/:page', action: :index, on: :collection }

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
