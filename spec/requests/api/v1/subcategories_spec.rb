# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Subcategories', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/api/v1/subcategories/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      get '/api/v1/subcategories/create'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /destroy' do
    it 'returns http success' do
      get '/api/v1/subcategories/destroy'
      expect(response).to have_http_status(:success)
    end
  end
end
