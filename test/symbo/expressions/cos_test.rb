# frozen_string_literal: true

require 'test_helper'

require 'symbo'

module Symbo
  class CosTest < ActiveSupport::TestCase
    include Symbo

    using Symbo

    test 'Cos[x] → Cos[x]' do
      assert_equal Cos[:x], Cos[:x].simplify
    end

    test 'Cos[-1] → Cos[1]' do
      assert_equal Cos[1], Cos[-1].simplify
    end

    test 'Cos[-1 * 2 * 3] → Cos[6]' do
      assert_equal Cos[6], Cos[Product[-1, 2, 3]].simplify
    end

    test 'Cos[0] → 1' do
      assert_equal 1, Cos[0].simplify
    end

    test 'Cos[π/6] → √3/2' do
      assert_equal (√(3)/2).simplify, Cos[(1/6) * PI].simplify
      assert_equal (√(3)/2).simplify, Cos[PI/6].simplify
    end

    test 'Cos[π/4] → 1/√2' do
      assert_equal (1/√(2)).simplify, Cos[(1/4) * PI].simplify
      assert_equal (1/√(2)).simplify, Cos[PI/4].simplify
    end

    test 'Cos[π/3] → 1/2' do
      assert_equal 1/2, Cos[(1/3) * PI].simplify
      assert_equal 1/2, Cos[PI/3].simplify
    end

    test 'Cos[π/2] → 0' do
      assert_equal 0, Cos[(1/2) * PI].simplify
      assert_equal 0, Cos[PI/2].simplify
    end

    test 'Cos[2π/3] → -1/2' do
      assert_equal (-1/2), Cos[(2/3) * PI].simplify
    end

    test 'Cos[3π/4] → -1/√2' do
      assert_equal (-1/√(2)).simplify, Cos[(3/4) * PI].simplify
    end

    test 'Cos[5π/6] → -√3/2' do
      assert_equal Product[-1, √(3)/2].simplify, Cos[(5/6) * PI].simplify
    end

    test 'Cos[π] → -1' do
      assert_equal(-1, Cos[1/1 * PI].simplify)
      assert_equal(-1, Cos[PI].simplify)
    end

    test 'Cos[7π/6] → -√3/2' do
      assert_equal Product[-1, √(3)/2].simplify, Cos[(7/6) * PI].simplify
    end

    test 'Cos[5π/4] → -1/√2' do
      assert_equal (-1/√(2)).simplify, Cos[(5/4) * PI].simplify
    end

    test 'Cos[4π/3] → -1/2' do
      assert_equal (-1/2), Cos[(4/3) * PI].simplify
    end

    test 'Cos[3π/2] → 0' do
      assert_equal 0, Cos[(3/2) * PI].simplify
    end

    test 'Cos[5π/3] → 1/2' do
      assert_equal 1/2, Cos[(5/3) * PI].simplify
    end

    test 'Cos[7π/4] → 1/√2' do
      assert_equal (1/√(2)).simplify, Cos[(7/4) * PI].simplify
    end

    test 'Cos[11π/6] → √3/2' do
      assert_equal (√(3)/2).simplify, Cos[(11/6) * PI].simplify
    end

    test 'Cos[2π] → 1' do
      assert_equal 1, Cos[(2/1) * PI].simplify
      assert_equal 1, Cos[Product[2, PI]].simplify
    end

    test 'Cos[-π/6] → √3/2' do
      assert_equal (√(3)/2).simplify, Cos[(-1/6) * PI].simplify
    end

    test 'Cos[-π/4] → 1/√2' do
      assert_equal (1/√(2)).simplify, Cos[(-1/4) * PI].simplify
      assert_equal (1/√(2)).simplify, Cos[-PI/4].simplify
    end

    test 'Cos[-π/3] → 1/2' do
      assert_equal 1/2, Cos[(-1/3) * PI].simplify
    end

    test 'Cos[-π/2] → 0' do
      assert_equal 0, Cos[(-1/2) * PI].simplify
    end

    test 'Cos[-2π/3] → -1/2' do
      assert_equal (-1/2), Cos[(-2/3) * PI].simplify
    end

    test 'Cos[-3π/4] → -1/√2' do
      assert_equal (-1/√(2)).simplify, Cos[(-3/4) * PI].simplify
    end

    test 'Cos[-5π/6] → -√3/2' do
      assert_equal Product[-1, √(3)/2].simplify, Cos[(-5/6) * PI].simplify
    end

    test 'Cos[-π/1] → -1' do
      assert_equal(-1, Cos[(-1/1) * PI].simplify)
    end

    test 'Cos[-π] → -1' do
      assert_equal(-1, Cos[-PI].simplify)
    end
  end
end
