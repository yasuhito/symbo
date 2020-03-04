# frozen_string_literal: true

require 'test_helper'

require 'symbo'

module Symbo
  class IntegerTest
    using Symbo

    class PowerTransformationTest < ActiveSupport::TestCase
      test 'Integer#base → UNDEFINED' do
        assert_equal UNDEFINED, 1.base
      end

      test 'Integer#exponent → UNDEFINED' do
        assert_equal UNDEFINED, 1.exponent
      end
    end

    class BasicDistributiveTransformationTest < ActiveSupport::TestCase
      test 'Integer#term → UNDEFINED' do
        assert_equal UNDEFINED, 1.term
      end

      test 'Integer#const → UNDEFINED' do
        assert_equal UNDEFINED, 1.const
      end
    end

    class OrderRelationTest < ActiveSupport::TestCase
      test '2.compare(4) → true' do
        assert 2.compare(4)
      end

      test '2.compare(5/2) → true' do
        assert 2.compare(5/2)
      end

      test '2.compare(:x + :y) → true' do
        assert 2.compare(:x + :y)
      end

      test '2.compare(:x * :y) → true' do
        assert 2.compare(:x * :y)
      end

      test '2.compare(2**:x) → true' do
        assert 2.compare(2**:x)
      end

      test '2.compare(2!) → true' do
        assert 2.compare(Factorial[2])
      end

      test '2.compare(Function[:f, :x]) → true' do
        assert 2.compare(Function[:f, :x])
      end
    end
  end
end
