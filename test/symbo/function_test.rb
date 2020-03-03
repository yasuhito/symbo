# frozen_string_literal: true

require 'test_helper'

require 'symbo/function'
require 'symbo/integer'
require 'symbo/product'
require 'symbo/symbol'

module Symbo
  class FunctionTest
    using Symbo

    class PowerTransformationTest < ActiveSupport::TestCase
      test 'Function#base → Function' do
        assert_equal Function[:f, :x], Function[:f, :x].base
      end

      test 'Function#exponent → 1' do
        assert_equal 1, Function[:f, :x].exponent
      end
    end

    class BasicDistributiveTransformationTest < ActiveSupport::TestCase
      include Symbo

      test 'Function#term = Product[Function]' do
        assert_equal Product[Function[:f, :x]], Function[:f, :x].term
      end

      test 'Function#const = 1' do
        assert_equal 1, Function[:f, :x].const
      end
    end

    class OrderRelationTest < ActiveSupport::TestCase
      test 'f(x).compare(g(x)) = true' do
        assert Function[:f, :x].compare(Function[:g, :x])
      end

      test 'f(x).compare(f(y)) = true' do
        assert Function[:f, :x].compare(Function[:f, :y])
      end

      test 'g(x).compare(g(x, y)) = true' do
        assert Function[:g, :x].compare(Function[:g, :x, :y])
      end

      test 'f(x).compare(f) → false' do
        assert_not Function[:f, :x].compare(:f)
      end

      test 'f(x).compare(g) → false' do
        assert Function[:f, :x].compare(:g)
      end
    end
  end
end
