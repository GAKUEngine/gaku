Gaku::Core::Engine.routes.draw do
  namespace :api do
    namespace :v1 do
      mount ActionCable.server => '/cable'

      resource :status

      post 'authenticate', to: 'authentication#authenticate'
      post 'authenticate/refresh', to: 'authentication#refresh'

      resources :students, model_name: 'Gaku::Student' do
        resources :guardians, controller: 'students/guardians'
        resources :student_guardians, controller: 'students/student_guardians', only: %i(create destroy)
        resources :courses, controller: 'students/courses'
        resources :class_groups, controller: 'students/class_groups'
        resources :extracurricular_activities, controller: 'students/extracurricular_activities'
        resources :exam_sessions, controller: 'students/exam_sessions'
        resources :contacts, controller: 'students/contacts'
        resources :addresses, controller: 'students/addresses'

        get :picture, on: :member
        get :search, on: :collection
      end

      resources :guardians, model_name: 'Gaku::Guardian' do
        resources :contacts
        resources :addresses
      end

      resources :exams do
        resources :exam_portions, controller: 'exams/exam_portions' do
          resources :exam_portion_scores, controller: 'exams/exam_portions/exam_portion_scores'
        end
      end

      resources :exam_portion_scores, only: :update

      resources :courses do
        resources :students, controller: 'courses/students'
        resources :enrollments, controller: 'courses/enrollments'
      end

      resources :class_groups do
        resources :students, controller: 'class_groups/students'
        resources :enrollments, controller: 'class_groups/enrollments'
      end

      resources :syllabuses do
        resources :courses, controller: 'syllabuses/courses'
        resources :exams, controller: 'syllabuses/exams'
      end
      resources :contact_types
      resources :enrollment_statuses
      resources :users do
        resources :user_roles, controller: 'users/user_roles'
      end

      resources :roles, only: :index
      resources :enrollment_statuses, only: :index
    end
  end
end
