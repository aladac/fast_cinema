# frozen_string_literal: true

Rails.application.routes.draw do
  resources :movies, only: %i[show index]

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
end
