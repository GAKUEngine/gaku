GAKUEngine::Application.routes.draw do
  devise_for :users

  resources :class_groups
  resources :class_group_enrollments

  resources :teachers

  resources :courses
  resources :course_enrollments

  resources :syllabuses

  resources :students

  resources :exams

  root :to => 'home#index'

end
