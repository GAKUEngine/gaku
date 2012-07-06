GAKUEngine::Application.routes.draw do

  devise_for :installs
  devise_for :users

  resources :class_groups

  resources :courses do
    resources :course_enrollments
  end

  resources :syllabuses

  resources :students do
  	resources :profiles 
    resources :guardians
  	resources :exams
  	resources :courses
  	resources :address
  	resources :contacts
  end

  resources :semesters

  resources :exams do 
    resources :exam_scores
  end

  root :to => 'home#index'

end
