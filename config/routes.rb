# frozen_string_literal: true

Rails.application.routes.draw do
  root to: redirect('/api-docs')

  resources :movies, only: %i[show index]
  resources :prices
  resources :showings

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
end
