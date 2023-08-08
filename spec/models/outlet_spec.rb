# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Outlet, type: :model do
  describe 'Association' do
    it { should belong_to(:user) }
    it { should have_many(:outlet_product) }
    it { should have_many(:product).through(:outlet_product) }
  end
end
