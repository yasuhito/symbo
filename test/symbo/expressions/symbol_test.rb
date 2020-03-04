# frozen_string_literal: true

require 'test_helper'

require 'symbo'

module Symbo
  class SymbolTest
    using Symbo

    class PowerTransformationTest < ActiveSupport::TestCase
      test 'Symbol#base → Symbol' do
        assert_equal :x, :x.base
      end

      test 'Symbol#exponent → 1' do
        assert_equal 1, :x.exponent
      end
    end

    class BasicDistributiveTransformationTest < ActiveSupport::TestCase
      test 'Symbol#term → Product[Symbol]' do
        assert_equal Product[:x], :x.term
      end

      test 'Symbol#const → 1' do
        assert_equal 1, :x.const
      end
    end

    class OrderRelationTest < ActiveSupport::TestCase
      test ':a.compare(:b) → true' do
        assert :a.compare(:b)
      end

      test ':A.compare(:a) → true' do
        assert :A.compare(:b)
      end

      test ':v1.compare(:v2) → true' do
        assert :v1.compare(:v2)
      end

      test ':x1.compare(:xa) → true' do
        assert :x1.compare(:xa)
      end

      test ':x.compare(:x**2) → true' do
        assert :x.compare(:x**2)
      end

      test 'x.compare(x(t)) = true' do
        assert :x.compare(Function[:x, :t])
      end

      test 'x.compare(y(t)) = true' do
        assert :x.compare(Function[:y, :t])
      end
    end
  end
end
