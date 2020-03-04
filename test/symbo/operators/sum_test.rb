# frozen_string_literal: true

require 'test_helper'

require 'symbo'

module Symbo
  class SumTest
    using Symbo

    class PowerTransformationTest < ActiveSupport::TestCase
      test 'Sum#base → Sum' do
        assert_equal (:x + :y), (:x + :y).base
      end

      test 'Sum#exponent → 1' do
        assert_equal 1, (:x + :y).exponent
      end
    end

    class BasicDistributiveTransformationTest < ActiveSupport::TestCase
      test 'Sum#term → Product[Sum]' do
        assert_equal Product[:x + :y], (:x + :y).term
      end

      test 'Sum#const → 1' do
        assert_equal 1, (:x + :y).const
      end
    end

    class OrderRelationTest < ActiveSupport::TestCase
      test '(a + b).compare(a + c) → true' do
        assert((:a + :b).compare(:a + :c))
      end

      test '(a + c + d).compare(b + c + d) → true' do
        assert Sum[:a, :c, :d].compare(Sum[:b, :c, :d])
      end

      test '(c + d).compare(b + c + d) → true' do
        assert((:c + :d).compare(Sum[:b, :c, :d]))
      end

      test '(1 + x).compare(y) → true' do
        assert((1 + :x).compare(:y))
      end
    end

    class SimplificationTest < ActiveSupport::TestCase
      using Symbo

      test '1/0 + 2 → Undefined + 2 → Undefined' do
        assert_equal UNDEFINED, Sum[1/0, 2].simplify
      end

      test '+2 → 2' do
        assert_equal 2, Sum[2].simplify
      end

      test '1 + 1 → 2' do
        assert_equal 2, Sum[1, 1].simplify
      end

      test 'a + b - a → b' do
        assert_equal :b, Sum[:a, :b, Product[-1, :a]].simplify
      end

      test 'c + 2 + b + c + a → 2 + a + b + 2c' do
        assert_equal Sum[2, :a, :b, Product[2, :c]],
                     Sum[:c, 2, :b, :c, :a].simplify
      end

      test '(2 + a + c + e) + (3 + b + d + e) → 6 + a + b + c + d + 2e' do
        assert_equal Sum[5, :a, :b, :c, :d, Product[2, :e]],
                     Sum[Sum[2, :a, :c, :e], Sum[3, :b, :d, :e]].simplify
      end

      test '(a + b) + c + b → a + 2b + c' do
        assert_equal Sum[:a, Product[2, :b], :c], Sum[Sum[:a, :b], :c, :b].simplify
      end

      test '(a + c + e) + (a - c + d + f) → 2a + d + e + f' do
        assert_equal Sum[Product[2, :a], :d, :e, :f],
                     Sum[Sum[:a, :c, :e], Sum[:a, Product[-1, :c], :d, :f]].simplify
      end
    end

    class ToStringTest < ActiveSupport::TestCase
      test 'Sum[:a, :b, :c, :d].to_s → a + b + c + d' do
        assert_equal 'a + b + c + d', Sum[:a, :b, :c, :d].to_s
      end

      test 'Sum[Sum[:a, :b, :c], Sum[:d, :e, :f]].to_s → (a + b + c) + (d + e + f)' do
        assert_equal '(a + b + c) + (d + e + f)', Sum[Sum[:a, :b, :c], Sum[:d, :e, :f]].to_s
      end

      test 'Sum[Sum[:a, :b, :c], Product[:d, :e, :f]].to_s → (a + b + c) + (d*e*f)' do
        assert_equal '(a + b + c) + d*e*f', Sum[Sum[:a, :b, :c], Product[:d, :e, :f]].to_s
      end

      test 'Sum[1/0, 2].to_s → 1/0 + 2' do
        assert_equal '1/0 + 2', Sum[1/0, 2].to_s
      end

      test 'Sum[:a, Sum[2]].to_s → a + 2' do
        assert_equal 'a + 2', Sum[:a, Sum[2]].to_s
      end

      test 'Sum[:a, :b, Product[-1, :a]].to_s → a + b - a' do
        assert_equal 'a + b - a', Sum[:a, :b, Product[-1, :a]].to_s
      end
    end
  end
end
