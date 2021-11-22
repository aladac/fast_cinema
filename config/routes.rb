# frozen_string_literal: true

Rails.application.routes.draw do
  root to: redirect('/api-docs')

  get 'showtime', to: 'showtime#index'

  resources :movies, only: %i[show index] do
    post 'review/:rating', on: :member, to: 'movies#review', as: :rate
  end

  resources :prices
  resources :showings

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
end
