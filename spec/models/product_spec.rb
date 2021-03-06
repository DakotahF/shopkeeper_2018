require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'when name is missing' do
    it 'is not valid' do
      product = Product.new(price: 100)
      expect(product).not_to be_valid
    end
  end

  context 'when name is not unique' do
    it 'is not valid' do
      Product.create!(name: 'Horse', price: 50000)
      product = Product.new(name: 'Horse', price: 50000)
      expect(product).not_to be_valid
    end
  end

  context 'when price is missing' do
    it 'is not valid' do
      product = Product.new(name: 'Horse')
      expect(product).not_to be_valid
    end
  end

  describe '#quantity' do
    it 'reflects inventory adjustments' do
      product = Product.create!(
        name: 'Stapler',
        price: 8000
      )
      product.inventory_adjustments.create!(quantity: 10)

      expect(product.quantity).to eq(10)
    end
  end
end
