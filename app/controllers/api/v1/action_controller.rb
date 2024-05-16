class Api::V1::ActionController < ApplicationController
  before_action :verify_csrf_token_for_api_calls

  def verify_csrf_token_for_api_calls
    unless valid_authenticity_token?(session, request.headers['X-CSRF-Token'])
      render json: { error: 'CSRF token verification failed' }, status: :forbidden
    end
  end
end
