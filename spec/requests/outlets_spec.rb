# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Outlets', type: :request do
  let!(:admin_user) { create(:user, role: 'admin') }
  let!(:outlet_a) { create(:outlet, status: 'accepted', user_id: admin_user.id) }
  let!(:outlet_b) {create(:outlet, status: 'accepted', user_id: admin_user.id)}
  let!(:outlet_c) {create(:outlet, status: 'accepted', user_id: admin_user.id)}


  describe 'Functionality of Outlet' do
    describe 'get index' do
      context 'get all the outlet that have the status accepted' do
        it 'returns the outlet with accepted status' do
          get '/outlets'
          binding.pry
          expect(json.pluck("status")).to eq('accepted')
        end
        it 'returns response of http status 200' do
          get '/outlets'
          expect(response).to have_http_status(200)

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

    describe 'Pending Outlet list' do
      context 'Show list of pending outlets' do
        let!(:outlet_p) {create(:outlet, status: 'pending', user_id: admin_user.id)}
        it 'should give list of pending outlets' do
          get '/pendings'
          response_pending = JSON.parse(response.body)
          expect(response_pending[0]['status']).to eq(outlet_p.status)
        end
      end
    end

    describe 'Pending Outlet show' do
      let!(:outlet_p) { create(:outlet, status: 'pending', user_id: admin_user.id) }
      context 'pending outlet present' do
        it 'shows the pending outlet' do
          get "/outlets/pending/#{outlet_p.id}"
          response_pending_show = JSON.parse(response.body)
          expect(response_pending_show['id']).to eq(response_pending2[:id])
        end
      end
      context 'pending outlet not present' do
        let!(:outlet_p) { create(:outlet, status: 'pending', user_id: admin_user.id) }
        it 'will not show outlet' do
          get "/outlets/pending/0"
          expect(response).to have_http_status(404)
        end
      end
    end

  end
end
