# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user_a) { create(:user) }

  describe 'Association' do
    it { should have_many(:orders) }
    it { should have_one(:outlet) }
  end

  describe 'validations of users' do
    it do
      is_expected.to validate_presence_of(:name)
    end
    it { is_expected.to validate_presence_of(:email) }
    it do
      is_expected.to validate_uniqueness_of(:email).case_insensitive
    end
    it { is_expected.to validate_length_of(:email).is_at_most(255) }

    it { is_expected.to validate_length_of(:password).is_at_least(6) }
    it { is_expected.to validate_presence_of(:role) }
  end
  describe 'callbacks' do
    it 'normalizes the email before validations' do
      email = ' sourav@example.com'
      user.email = email.upcase
      user.save!

      expect(user.email).to eq('sourav@example.com')
    end
    it 'generates user auth_token at random' do
      user.auth_token = nil
      user.save!

      expect(user.auth_token).to be_present
    end
  end
end
