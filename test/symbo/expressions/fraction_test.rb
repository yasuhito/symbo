# frozen_string_literal: true

require 'test_helper'

require 'symbo'

module Symbo
  class FractionTest
    using Symbo

    class PowerTransformationTest < ActiveSupport::TestCase
      test 'Fraction#base → UNDEFINED' do
        assert_equal UNDEFINED, (1/3).base
      end

      test 'Fraction#exponent → UNDEFINED' do
        assert_equal UNDEFINED, (1/3).exponent
      end
    end

    class BasicDistributiveTransformationTest < ActiveSupport::TestCase
      test 'Fraction#term → UNDEFINED' do
        assert_equal UNDEFINED, (1/3).term
      end

      test 'Fraction#const = UNDEFINED' do
        assert_equal UNDEFINED, (1/3).const
      end
    end

    class OrderRelationTest < ActiveSupport::TestCase
      test '(1/2).compare(4) → true' do
        assert((1/2).compare(4))
      end

      test '(1/2).compare(5/2) → true' do
        assert((1/2).compare(5/2))
      end

      test '(1/2).compare(:x + :y) → true' do
        assert((1/2).compare(:x + :y))
      end

      test '(1/2).compare(:x * :y) → true' do
        assert((1/2).compare(:x * :y))
      end

      test '(1/2).compare(2**:x) → true' do
        assert((1/2).compare(2**:x))
      end

      test '(1/2).compare(2!) → true' do
        assert((1/2).compare(Factorial[2]))
      end

      test '(1/2).compare(Function[:f, :x]) → true' do
        assert((1/2).compare(Function[:f, :x]))
      end
    end

    class ToStringTest < ActiveSupport::TestCase
      test '(1/2).to_s → 1/2' do
        assert_equal '1/2', (1/2).to_s
      end
    end
  end
end
