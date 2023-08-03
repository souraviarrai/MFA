# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user_a) { create(:user) }
  let(:valid_attributes) { { name: 'sourav rai', email: 'sourav@example.com', password: 'meropass', role: 'admin' } }
  let(:invalid_attributes) { { email: 'sourav@example.com', password: '' } }

  describe 'While creating #create' do
    context 'when the request is valid' do
      it 'creates the users' do
        post users_path, params: { user: valid_attributes }
      end
      it 'stores the auth_token in the coookie' do
        post users_path, params: { user: valid_attributes }
        binding.pry
        expect(signed_cookie[:auth_token]).to eq(User.first.auth_token)
      end
    end
    context 'when the request is invalid' do
      it 'returns an error' do
        post users_path, params: { user: invalid_attributes }

        expect(json.dig(:errors, :password)).to be_present
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
