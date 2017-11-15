Gaku::Core::Engine.routes.draw do
  namespace :api do
    resource :status
    namespace :v1 do

      concern :enrollable do
        resources :enrollments, only: %i( create destroy )
      end

      concern :enrollable do
        resources :enrollments
      end


      post 'authenticate', to: 'authentication#authenticate'
      post 'authenticate/refresh', to: 'authentication#refresh'

      resources :students do
        resources :guardians, controller: 'students/guardians'
        resources :courses, controller: 'students/courses'
        resources :class_groups, controller: 'students/class_groups'
        resources :extracurricular_activities, controller: 'students/extracurricular_activities'
        resources :exam_sessions, controller: 'students/exam_sessions'
      end

      resources :courses, concerns: %i( enrollable )
    end
  end
end
