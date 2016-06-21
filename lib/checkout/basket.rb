module Checkout
  class Basket
    attr_accessor :line_items, :promo_rules, :amount

    def initialize(promo_rules = [])
      @line_items = []
      @promo_rules = promo_rules
    end

    def scan(item)
      line_items << item
    end

    def total
      @amount = items_total
      process_adjustments
      (amount * 100).round / 100.0
    end

    private

      # Adjustments are cumulative which means the order of the rules matter.
      def process_adjustments
        promo_rules.each do |rule|
          @amount = amount - rule.adjustment(self)
        end
      end

      def items_total
        line_items.map(&:price).inject(0) { |sum, x| sum + x }
      end
  end
end
