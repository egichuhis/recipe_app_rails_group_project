require 'rails_helper'

RSpec.describe 'ShoppingLists', type: :request do
  describe 'GET /general' do
    it 'returns http success' do
      get '/shopping_list/general'
      expect(response).to have_http_status(:success)
    end
  end
end
