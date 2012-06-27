GAKUEngine::Application.routes.draw do

  devise_for :users

  resources :class_groups
  resources :class_group_enrollments

  resources :courses
  resources :course_enrollments

  resources :syllabuses

  resources :students do 
  	resources :profiles 
  	resources :exams
  	resources :courses
  	resources :address
  	resources :contacts
  end

  resources :exams

  root :to => 'home#index'

end
