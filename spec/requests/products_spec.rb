# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products', type: :request do
  let!(:admin_user) { create(:user, role: 'admin') }
  let!(:normal_user) { create(:user, role: 'user') }

  describe 'Create' do
    context 'When the user is admin' do
      before do
        login(admin_user)
      end
      context 'with valid parameters' do
        let(:valid_params) do
          { product: { name: Faker::Company.bs , description: Faker::Address.full_address } }
        end
        it 'creates the new product' do
          expect { post '/products', params: valid_params }.to change(Product, :count).by(1)


        end
        it 'responds true if the given params and recived params are same' do
          binding.pry
          post '/products', params: valid_params
          expect(json).to have_attributes(
                            name: valid_params[:product][:name],
                            description: valid_params[:product][:description]
                          )
        end
        it 'responds with status ok' do
          post '/products', params: valid_params
          expect(response).to have_http_status(201)
        end
      end

      context 'with invalid parameters' do
        let(:invalid_params) do
          {product: {name: '', description: 'des'}}
        end
        it 'creates it does not create new product' do
          expect { post '/products', params: invalid_params}.not_to change(Product, :count)
        end
        it 'render error message as JSON' do
          post '/products', params: invalid_params
          expect(response).to have_http_status(422)
        end
      end
    end

    context 'when the user is non-admin' do
      before do
        login(normal_user)
      end
      let(:valid_params) do
        { product: { name: 'name', description: 'des' } }
      end
      it 'responds with status unauthorized' do
        post '/products', params: valid_params
        expect(response).to have_http_status(:unauthorized)
      end
      it 'does not create a new product' do
        expect{post '/products', params: valid_params}.not_to change(Product, :count)
      end
    end
  end
end
