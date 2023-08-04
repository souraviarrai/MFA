# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products', type: :request do
  let!(:admin_user) { create(:user, status:'admin') }
  let!(:normal_user) { create(:user, status:'user') }

  describe 'Create' do
    context 'When the user is admin' do
      before do
        login(:admin_user)
      end
      context 'with valid parameters' do
        let(:valid_params) do
          { product: { name: 'name', description: 'des' } }
        end
        it 'creates the new product' do
          expect { post :create, params: valid_params }.to change(Product, :count).by(1)
        end
        it 'responds with status ok' do
          post :create, params: valid_params
          expect(response).to have_http_status(200)
        end
      end

      context 'with invalid parameters' do
        let(:invalid_params) do
          {product: {name: '', description: 'des'}}
        end
        it 'creates it does not create new product' do
          expect { post :create, params: invalid_params}.not_to change(Product, :count)
        end
        it 'render error message as JSON' do
          post :create, params: invalid_params
          expect(response).to have_http_status(422)
        end
      end
    end

    context 'when the user is non-admin' do
      before do
        login(:normal_user)
      end
      it 'responds with status unauthorized' do
        post :create
        expect(response).to have_http_status(:unauthorized)
      end
      it 'does not create a new product' do
        expect{post :create}.not_to change(Product, :count)
      end
    end
  end
end
