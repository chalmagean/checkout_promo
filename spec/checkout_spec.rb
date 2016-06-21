require 'spec_helper'

module Checkout
  describe Basket do
    it 'has a version number' do
      expect(VERSION).not_to be nil
    end

    describe 'discounts' do
      context 'when no promotional rules are specified' do
        it 'summs the line item prices' do
          p1 = double('P1', sku: '001', price: 9.25)
          p2 = double('P2', sku: '002', price: 45.00)
          p3 = double('P3', sku: '003', price: 19.95)

          co = Basket.new
          co.scan(p1)
          co.scan(p2)
          co.scan(p3)
          expect(co.total).to eq(74.20)
        end
      end

      context 'when you spend over £60' do
        it 'reduces the total cost by 10%' do
          p1 = double('P1', sku: '001', price: 9.25)
          p2 = double('P2', sku: '002', price: 45.00)
          p3 = double('P3', sku: '003', price: 19.95)

          rule = TenPercent.new
          co = Basket.new([rule])
          co.scan(p1)
          co.scan(p2)
          co.scan(p3)
          expect(co.total).to eq(66.78)
        end
      end

      context 'when you buy to or more travel card holders' do
        it 'the price of the card holders drops to £8.50' do
          p1 = double('P1', sku: '001', price: 9.25)
          p3 = double('P3', sku: '003', price: 19.95)

          rule = TwoOrMore.new('001')
          co = Basket.new([rule])
          co.scan(p1)
          co.scan(p3)
          co.scan(p1)
          expect(co.total).to eq(36.95)
        end
      end

      context 'two travel card holders and > 60' do
        it 'combines the discounts' do
          p1 = double('P1', sku: '001', price: 9.25)
          p2 = double('P2', sku: '002', price: 45.00)
          p3 = double('P3', sku: '003', price: 19.95)

          rule1 = TwoOrMore.new('001')
          rule2 = TenPercent.new
          co = Basket.new([rule1, rule2])
          co.scan(p1)
          co.scan(p2)
          co.scan(p1)
          co.scan(p3)
          expect(co.total).to eq(73.76)
        end
      end
    end
  end
end
