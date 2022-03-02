Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'recipes/index'
      post 'recipes/create'
      get 'recipes/show/:id', to: 'recipes#show'
      delete 'recipes/destroy/:id', to: 'recipes#destroy'
    end
  end
  namespace :api do
    namespace :v1 do
      get 'tags/index'
      post 'tags/create'
      get 'tags/edit/:id', to: 'tags#edit'
      post 'tags/update/:id', to: 'tags#update'
      delete 'tags/destroy/:id', to: 'tags#destroy'
    end
  end
  namespace :api do
    namespace :v1 do
      get 'subcategories/index'
      post 'subcategories/create'
      get 'subcategories/edit/:id', to: 'subcategories#edit'
      post 'subcategories/update/:id', to: 'subcategories#update'
      delete 'subcategories/destroy/:id', to: 'subcategories#destroy'
    end
  end
  namespace :api do
    namespace :v1 do
      get 'categories/index'
      post 'categories/create'
      get 'categories/edit/:id', to: 'categories#edit'
      post 'categories/update/:id', to: 'categories#update'
      delete 'categories/destroy/:id', to: 'categories#destroy'
    end
  end
  namespace :api do
    namespace :v1 do
      post 'sections/create'
      post 'sections/save_multiple'
      get 'sections/edit/:id', to: 'sections#edit'
      get 'sections/find_by_recipe_id/:id', to: 'sections#find_by_recipe_id'
      post 'sections/update/:id', to: 'sections#update'
      delete 'sections/destroy/:id', to: 'sections#destroy'
    end
  end
  namespace :api do
    namespace :v1 do
      post 'steps/create'
      get 'steps/edit/:id', to: 'steps#edit'
      get 'steps/find_by_recipe_id/:id', to: 'steps#find_by_recipe_id'
      get 'steps/find_by_section_id/:id', to: 'steps#find_by_section_id'
      post 'steps/update/:id', to: 'steps#update'
      delete 'steps/destroy/:id', to: 'steps#destroy'
    end
  end
  
  root 'homepage#index'
  get '/*path' => 'homepage#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  

  
  
end
