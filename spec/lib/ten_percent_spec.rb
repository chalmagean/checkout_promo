require 'spec_helper'

module Checkout
  describe TenPercent do
    it 'returns the adjustment required for two or more items' do
      basket = double('Basket', amount: 100)
      tp = TenPercent.new
      expect(tp.adjustment(basket)).to eq(10.00)
    end
  end
end
