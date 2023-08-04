# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  let!(:admin_user) { create(:user, role: 'admin') }
  let!(:normal_user) { create(:user, role: 'user') }

  describe 'GET /index' do
    context 'when user is admin' do
      it 'proper test description' do
        login(admin_user)

      end
    end

    context 'when user is not admin' do

    end

    context 'with invalid params' do

    end
  end
end
