# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Outlets', type: :request do
  let!(:admin_user) { create(:user, role: 'admin') }
  let!(:normal_user) { create(:user, role: 'user' ) }
  let!(:outlet_a) { create(:outlet, status: 'accepted', user_id: admin_user.id) }
  let!(:outlet_b) {create(:outlet, status: 'accepted', user_id: admin_user.id)}
  let!(:outlet_c) {create(:outlet, status: 'accepted', user_id: admin_user.id)}
  let!(:outlet_d) {create(:outlet, status: 'pending', user_id: admin_user.id)}
  let!(:outlet_e) {create(:outlet, status: 'pending', user_id: admin_user.id)}

  describe 'Functionality of Outlet' do
    describe 'get index' do
      context 'get all the outlet that have the status accepted' do
        before do
          login(admin_user)
        end
        it 'returns the outlet with accepted status' do
          get '/outlets?status=accepted'
          expect(json.pluck("status").uniq).to eq(['accepted'])
        end
        it 'should return the outlet with pending status' do
          get '/outlets?status=pending'
          expect(json.pluck("status").uniq).to eq(['pending'])
        end
        it 'returns all the outlets' do
          get '/outlets'
          expect(json.length).to eq(5)
        end
        it 'should not accept any unwanted query params' do
          get '/outlets?status=lorem'
          expect(response).to have_http_status(400)
        end
      end

      context 'for normal user' do
        before do
            login(normal_user)
        end
        it 'return 401 when the user access the index page' do
          binding.pry
          get '/outlets'
          expect(response).to have_http_status(401)
        end
      end
    end

    describe 'show outlet' do
      context 'Accepted outlet' do
        let!(:outlet_a) {create(:outlet, status: 'accepted', user_id: admin_user.id)}
        it 'should show the outlet that are accepted' do
          get "/outlets/#{outlet_a.id}"
          response_show = JSON.parse(response.body)
          expect(response_show['name']).to eq(outlet_a.name)
        end
      end
      context 'Pending outlet' do
        let!(:outlet_p) {create(:outlet, status: 'pending', user_id: admin_user.id)}
        it 'should not show the outlet that are in pending' do
          get "/outlets/#{outlet_p.id}"
          expect(response).to have_http_status(404)
        end
      end
    end
  end

end
