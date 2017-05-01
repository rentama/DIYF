Rails.application.routes.draw do
  devise_for :users
  root 'categories#index'
  resources 'categories' do
    resources 'fermentations' do
      collection do
        get 'search'
      end
      resources 'products'do
      end
    end
  end
  resources 'users'
  # get '*path', controller: 'application', action: 'render_404'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
