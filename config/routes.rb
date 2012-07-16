GAKUEngine::Application.routes.draw do

  devise_for :installs
  devise_for :users

  resources :class_groups

  resources :semesters  

  resources :courses do
    resources :course_enrollments
  end

  resources :class_group_enrollments

  resources :syllabuses do 
    member do
      get :new_exam
      get :new_assignment
    end
  end

  resources :students do
  	resources :profiles 
    resources :guardians
    resources :addresses
    resources :notes
    resources :contacts
    resources :exams
    resources :courses
    resources :addresses
    get :new_address, :on => :member
  end
  

  resources :notes

  resources :exams do 
    resources :exam_scores
    resources :exam_portions
  end

  root :to => 'home#index'

end
