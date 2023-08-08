# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Association' do
    it { should belong_to(:user) }
    it { should belong_to(:outlet) }
    it { should belong_to(:product) }
  end
end
