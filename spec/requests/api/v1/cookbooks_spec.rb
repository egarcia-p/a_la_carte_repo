# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Cookbooks', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/cookbook/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      get '/cookbook/create'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get '/cookbook/edit'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /destroy' do
    it 'returns http success' do
      get '/cookbook/destroy'
      expect(response).to have_http_status(:success)
    end
  end
end
