require 'spec_helper'

module Checkout
  describe TwoOrMore do
    it 'returns the adjustment required for two or more items' do
      l1 = double('Item', sku: '001', price: 10.00)
      basket = double('Basket', line_items: [l1, l1])
      tm = TwoOrMore.new('001')
      expect(tm.adjustment(basket)).to eq(3)
    end
  end
end
