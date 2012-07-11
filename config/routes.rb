GAKUEngine::Application.routes.draw do

  devise_for :installs
  devise_for :users

  resources :class_groups

  resources :semesters  

  resources :courses do
    resources :course_enrollments
  end

  resources :class_group_enrollments

  resources :syllabuses

  resources :students do
  	resources :profiles 
    resources :guardians
    resources :notes
    resources :addresses
    resources :contacts
  	resources :exams
  	resources :courses
  end

  resources :notes

  resources :exams do 
    resources :exam_scores
    resources :exam_portions
  end

  root :to => 'home#index'

end
