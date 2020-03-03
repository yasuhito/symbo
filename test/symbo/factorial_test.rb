# frozen_string_literal: true

require 'test_helper'

require 'symbo/factorial'

module Symbo
  class FactorialTest
    using Symbo

    class PowerTransformationTest < ActiveSupport::TestCase
      test 'Factorial#base → Factorial' do
        assert_equal Factorial[:x], Factorial[:x].base
      end

      test 'Factorial#exponent → 1' do
        assert_equal 1, Factorial[:x].exponent
      end
    end

    class BasicDistributiveTransformationTest < ActiveSupport::TestCase
      test 'Factorial#term → Product[Factorial]' do
        assert_equal Product[Factorial[:x]], Factorial[:x].term
      end

      test 'Factorial#const → 1' do
        assert_equal 1, Factorial[:x].const
      end
    end

    class OrderRelationTest < ActiveSupport::TestCase
      test '(m!).compare(n) → true' do
        assert Factorial[:m].compare(:n)
      end

      test '(f(x)!).compare((f(x)) → false' do
        assert_not Factorial[Function[:f, :x]].compare(Function[:f, :x])
      end

      test '(:x!).compare(:x) → false' do
        assert_not Factorial[:x].compare(:x)
      end

      test '(:x!).compare(f(x)) → false' do
        assert_not Factorial[:x].compare(Function[:f, :x])
      end
    end
  end
end
