module Checkout
  class TenPercent
    attr_reader :base

    def adjustment(basket)
      @base = basket.amount
      match? ? base * 10.0 / 100.0 : 0
    end

    private

      def match?
        base > 60
      end
  end
end
