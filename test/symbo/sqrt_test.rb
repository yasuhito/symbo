# frozen_string_literal: true

require 'test_helper'

require 'symbo/sqrt'

module Symbo
  class SqrtTest < ActiveSupport::TestCase
    # test 'simplify √3' do
    #   sqrt = Sqrt.new(3)

    #   assert_equal sqrt, sqrt.simplify
    #   assert_equal '√3', sqrt.to_s
    # end

    # test 'simplify √4' do
    #   sqrt = Sqrt.new(4)

    #   assert_equal 2, sqrt.simplify
    # end

    # test 'simplify √(-1)' do
    #   sqrt = Sqrt.new(-1)

    #   assert_equal 1i, sqrt.simplify
    #   assert_equal '√(-1)', sqrt.to_s
    # end

    # test 'simplify √(-4)' do
    #   sqrt = Sqrt.new(-4)

    #   assert_equal 2i, sqrt.simplify
    # end

    # test '√2 == √2' do
    #   sqrt1 = Sqrt.new(2)
    #   sqrt2 = Sqrt.new(2)

    #   assert sqrt1 == sqrt2
    # end

    # test '√2*√2=2' do
    #   product = Product.new(Sqrt.new(2), Sqrt.new(2)).simplify

    #   assert_equal 2, product
    # end

    # test '√2*√3=√6' do
    #   product = Product.new(Sqrt.new(2), Sqrt.new(3)).simplify

    #   assert_equal Sqrt.new(6), product
    # end

    # test '√2*√3*√5=√30' do
    #   product = Product.new(Sqrt.new(2), Sqrt.new(3), Sqrt.new(5)).simplify

    #   assert_equal Sqrt.new(30), product
    #   assert_equal '√(30)', product.to_s
    # end

    # test '√2*√3*√3=3√2' do
    #   product = Product.new(Sqrt.new(2), Sqrt.new(3), Sqrt.new(3)).simplify

    #   assert_equal Product.new(3, Sqrt.new(2)), product
    #   assert_equal '3√2', product.to_s
    # end
  end
end
