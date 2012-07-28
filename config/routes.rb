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
  end

  resources :course_enrollments do
    post :enroll_student, :on => :collection
  end

  resources :class_group_enrollments do
    post :enroll_student, :on => :collection
  end

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
      get 'new_contact', :on => :member
      get 'edit_student_guardian', :on => :collection
    end
    resources :addresses
    resources :notes
    resources :contacts
    resources :exams
    resources :courses
    resources :contacts do
      post :make_primary, :on => :member
    end
    get :new_address, :on => :member
    put :create_address, :on => :collection
    get :new_guardian, :on => :member
    put :create_guardian, :on => :collection

    get :get_csv_template, :on => :collection
    post :import_student_list, :on => :collection
  end
  
  resources :addresses

  resources :notes

  resources :exams do 
    member do
      put :create_exam_portion  
    end
    resources :exam_scores
    resources :exam_portions
  end

  resources :states

  root :to => 'home#index'

end
