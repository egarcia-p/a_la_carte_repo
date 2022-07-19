require 'rails_helper'

RSpec.describe 'Api::V1::Uoms', type: :request do
  describe 'GET /create' do
    it 'returns http success' do
      get '/api/v1/uoms/create'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /destroy' do
    it 'returns http success' do
      get '/api/v1/uoms/destroy'
      expect(response).to have_http_status(:success)
    end
  end
end
