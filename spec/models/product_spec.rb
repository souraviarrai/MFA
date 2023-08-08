# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Assocation' do
    it { should have_many(:outlet_product) }
    it { should have_many(:outlet).through(:outlet_product) }
  end
end
