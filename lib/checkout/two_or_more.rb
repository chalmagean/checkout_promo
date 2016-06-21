module Checkout
  class TwoOrMore
    attr_reader :items, :sku

    def initialize(sku)
      @sku = sku
    end

    def adjustment(basket)
      @items = basket.line_items
      match? ? adjustment_amount : 0
    end

    private

      def match?
        items_by_sku.size >= 2
      end

      def items_by_sku
        items.select { |li| li.sku == sku}
      end

      def adjustment_amount
        initial_price = items_by_sku.map(&:price).inject(&:+)
        target_price = items_by_sku.size * 8.5
        initial_price - target_price
      end
  end
end
