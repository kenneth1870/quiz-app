# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Rapidfire::Engine => '/questionarie'
  root 'home#index'
  devise_for :users

  # If no route matches
  # match ":url" => "application#redirect_user", :constraints => { :url => /.*/ }
  # match '*path', via: :all, to: redirect('error/404')
  get '*path', to: 'errors#error_404', via: :all
end
