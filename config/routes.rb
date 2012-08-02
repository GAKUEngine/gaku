GAKUEngine::Application.routes.draw do

  devise_for :installs
  devise_for :users

  resources :class_groups

  resources :semesters  

  resources :courses do
    resources :exams do
      resources :exam_portion_scores
      get :grading, :on => :member
    end

    post :enroll_class_group, :on => :member
  end

  resources :course_enrollments do
    post :enroll_student, :on => :collection
  end

  resources :class_group_enrollments do
    post :enroll_student, :on => :collection
  end
  
  resources :exam_portion_scores

  resources :syllabuses do
    member do
      put :create_exam
      put :create_assignment
    end
    resources :exams
    resources :assignments
  end

  resources :students do
    resources :guardians do
      resources :contacts

      get :new_contact, :on => :member
      get :edit_student_guardian, :on => :collection
    end
    resources :addresses
    resources :notes
    resources :contacts
    resources :exams
    resources :courses
    resources :contacts do
      post :make_primary, :on => :member
    end

    member do
      get :new_address
      get :new_guardian
      get :new_note
    end

    collection do 
      put :create_address
      put :create_guardian
      put :create_note
      get :get_csv_template
      post :import_student_list
      get :autocomplete_search
    end

  end
  
  resources :addresses

  resources :notes

  resources :exams do 
    put :create_exam_portion, :on => :member  

    resources :exam_scores
    resources :exam_portions
  end

  resources :states

  root :to => 'home#index'

end
