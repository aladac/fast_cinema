# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate_api_key!, if: :authentication_needed?

  def authenticate_api_key!
    head(:unauthorized) and return if api_key.blank?

    @api_key ||= ApiKey.find_by(value: api_key)
    return if @api_key.present?

    head(:unauthorized)
  end

  def current_api_key
    @api_key
  end

  def authenticated?
    current_api_key.present?
  end

  def api_key
    params[:api_key] || request.headers['X-Api-Key']
  end

  def authentication_needed?
    %w[showings prices].include?(params[:controller])
  end
end
