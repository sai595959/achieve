Rails.application.routes.draw do


  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # dive14_snsでコメントに
  # devise_for :users

  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
}

    resources :blogs, only: [:index, :new, :create, :edit, :update, :destroy] do
        collection do
            post :confirm
        end
    end





    resources :contacts, only:[:new, :create] do
        collection do
            post :confirm
        end
    end

    resources :poems, only: [:index, :show]

    root 'top#index'

    if Rails.env.development?
      mount LetterOpenerWeb::Engine, at: "/letter_opener"
    end




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
