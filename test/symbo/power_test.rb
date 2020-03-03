# frozen_string_literal: true

require 'test_helper'

require 'symbo'

module Symbo
  class PowerTest
    using Symbo

    class PowerTransformationTest < ActiveSupport::TestCase
      test 'Power#base → Power#operands[0]' do
        assert_equal :x, (:x**2).base
      end

      test 'Power#exponent → Power#operands[1]' do
        assert_equal 2, (:x**2).exponent
      end
    end

    class BasicDistributiveTransformationTest < ActiveSupport::TestCase
      test 'Power#term → Product[Power]' do
        assert_equal Product[:x**2], (:x**2).term
      end

      test 'Product#const → 1' do
        assert_equal 1, (:x**2).const
      end
    end

    class OrderRelationTest < ActiveSupport::TestCase
      test '((1+x)^2).compare((1+x)^3) = true' do
        assert(((1 + :x)**2).compare((1 + :x)**3))
      end

      test '((1+x)^3).compare((1+y)^2) = true' do
        assert(((1 + :x)**3).compare((1 + :y)**2))
      end

      test '((1+x)^3).compare(1+y) = true' do
        assert(((1 + :x)**3).compare(1 + :y))
      end
    end

    class SimplificationTest < ActiveSupport::TestCase
      test '((1/0)^2).simplify = Undefined' do
        assert_equal UNDEFINED, ((1/0)**2).simplify
      end

      test '(2^(1/0)).simplify = Undefined' do
        assert_equal UNDEFINED, Power[2, 1/0].simplify
      end

      test '(0^2).simplify = 1' do
        assert_equal 1, Power[0, 2].simplify
      end

      test '(0^(1/2)).simplify = 1' do
        assert_equal 1, Power[0, 1/2].simplify
      end

      test '(0^(-1)).simplify = Undefined' do
        assert_equal UNDEFINED, Power[0, -1].simplify
      end

      test '(1^x).simplify = 1' do
        assert_equal 1, Power[1, :x].simplify
      end

      test '(2^2).simplify = 4' do
        assert_equal 4, Power[2, 2].simplify
      end

      test '(2^0).simplify = 1' do
        assert_equal 1, Power[2, 0].simplify
      end

      test '(2^1).simplify = 2' do
        assert_equal 2, Power[2, 1].simplify
      end

      test '(((x^(1/2))^(1/2))^8).simplify = x^2' do
        assert_equal (:x**2), Power[Power[Power[:x, 1/2], 1/2], 8].simplify
      end

      test '(((x·y)^(1/2)·z^2)^2).simplify = x·y·z^4' do
        assert_equal Product[:x, :y, Power[:z, 4]],
                     Power[Product[Power[Product[:x, :y], 1/2], Power[:z, 2]], 2].simplify
      end
    end
  end
end
