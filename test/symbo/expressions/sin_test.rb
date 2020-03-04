# frozen_string_literal: true

require 'test_helper'

require 'symbo'

module Symbo
  class SinTest < ActiveSupport::TestCase
    include Symbo

    using Symbo

    test 'Sin[x] → Sin[x]' do
      assert_equal Sin[:x], Sin[:x].simplify
    end

    test 'Sin[-1] → -Sin[1]' do
      assert_equal(-Sin[1], Sin[-1].simplify)
    end

    test 'Sin[-1 * 2 * 3] → -Sin[6]' do
      assert_equal(-Sin[6], Sin[Product[-1, 2, 3]].simplify)
    end

    test 'Sin[0] → 0' do
      assert_equal 0, Sin[0].simplify
    end

    test 'Sin[0π/1] → 0' do
      assert_equal 0, Sin[(0/1)*PI].simplify
    end

    test 'Sin[π/6] → 1/2' do
      assert_equal 1/2, Sin[(1/6)*PI].simplify
      assert_equal 1/2, Sin[PI/6].simplify
    end

    test 'Sin[π/4] → 1/√2' do
      assert_equal (1/√(2)).simplify, Sin[(1/4)*PI].simplify
      assert_equal (1/√(2)).simplify, Sin[PI/4].simplify
    end

    test 'Sin[π/3] → √3/2' do
      assert_equal (√(3)/2).simplify, Sin[(1/3)*PI].simplify
      assert_equal (√(3)/2).simplify, Sin[PI/3].simplify
    end

    test 'Sin[π/2] → 1' do
      assert_equal 1, Sin[(1/2)*PI].simplify
      assert_equal 1, Sin[PI/2].simplify
    end

    test 'Sin[2π/3] → √3/2' do
      assert_equal (√(3)/2).simplify, Sin[(2/3)*PI].simplify
    end

    test 'Sin[3π/4] → 1/√2' do
      assert_equal (1/√(2)).simplify, Sin[(3/4)*PI].simplify
    end

    test 'Sin[5π/6] → 1/2' do
      assert_equal 1/2, Sin[(5/6)*PI].simplify
    end

    test 'Sin[π] → 0' do
      assert_equal 0, Sin[(1/1)*PI].simplify
      assert_equal 0, Sin[PI].simplify
    end

    test 'Sin[7π/6] → -1/2' do
      assert_equal (-1/2), Sin[(7/6)*PI].simplify
    end

    test 'Sin[5π/4] → -1/√2' do
      assert_equal (-1/√(2)).simplify, Sin[(5/4)*PI].simplify
    end

    test 'Sin[4π/3] → -√3/2' do
      assert_equal Product[-1, √(3)/2].simplify, Sin[(4/3)*PI].simplify
    end

    test 'Sin[3π/2] → -1' do
      assert_equal(-1, Sin[(3/2)*PI].simplify)
    end

    test 'Sin[5π/3] → -√3/2' do
      assert_equal Product[-1, √(3)/2].simplify, Sin[(5/3)*PI].simplify
    end

    test 'Sin[7π/4] → -1/√2' do
      assert_equal (-1/√(2)).simplify, Sin[(7/4)*PI].simplify
    end

    test 'Sin[11π/6] → -1/2' do
      assert_equal (-1/2), Sin[(11/6)*PI].simplify
    end

    test 'Sin[2π] → 0' do
      assert_equal 0, Sin[(2/1)*PI].simplify
      assert_equal 0, Sin[Product[2, PI]].simplify
    end

    test 'Sin[-π/6] → √3/2' do
      assert_equal (-1/2), Sin[(-1/6)*PI].simplify
    end

    test 'Sin[-π/4] → -1/√2' do
      assert_equal (-1/√(2)).simplify, Sin[(-1/4)*PI].simplify
      assert_equal (-1/√(2)).simplify, Sin[-PI/4].simplify
    end

    test 'Sin[-π/3] → -√3/2' do
      assert_equal Product[-1, √(3)/2].simplify, Sin[(-1/3)*PI].simplify
    end

    test 'Sin[-π/2] → -1' do
      assert_equal(-1, Sin[(-1/2)*PI].simplify)
    end

    test 'Sin[-2π/3] → -√3/2' do
      assert_equal Product[-1, √(3)/2].simplify, Sin[(-2/3)*PI].simplify
    end

    test 'Sin[-3π/4] → -1/√2' do
      assert_equal (-1/√(2)).simplify, Sin[(-3/4)*PI].simplify
    end

    test 'Sin[-5π/6] → -1/2' do
      assert_equal (-1/2), Sin[(-5/6)*PI].simplify
    end

    test 'Sin[-π/1] → 0' do
      assert_equal 0, Sin[(-1/1)*PI].simplify
    end

    test 'Sin[-π] → 0' do
      assert_equal 0, Sin[-PI].simplify
    end
  end
end
