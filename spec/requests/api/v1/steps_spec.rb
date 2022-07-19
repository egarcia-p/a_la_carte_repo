# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Steps', type: :request do
  describe 'GET /create' do
    it 'returns http success' do
      get '/api/v1/steps/create'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /destroy' do
    it 'returns http success' do
      get '/api/v1/steps/destroy'
      expect(response).to have_http_status(:success)
    end
  end
end
