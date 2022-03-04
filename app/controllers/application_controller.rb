# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  def can_administer?
    current_user.try(:admin?)
  end

  unless Rails.application.config.consider_all_requests_local
    rescue_from ActionController::RoutingError, with: -> { render_404 }
  end

  def render_404
    respond_to do |format|
      format.html { render template: 'errors/not_found', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end
end
