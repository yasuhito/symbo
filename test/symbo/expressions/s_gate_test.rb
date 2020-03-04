# frozen_string_literal: true

require 'test_helper'

module Symbo
  class SGateTest < ActiveSupport::TestCase
    test 'S|0> = |0>' do
      assert_equal Qubit['0'], SGate.new.apply(Qubit['0'], 0)
    end

    test 'S|1> = i|1>' do
      assert_equal 1i * Qubit['1'], SGate.new.apply(Qubit['1'], 0)
    end

    test 'S|+> = |i>' do
      assert_equal Qubit['i'], SGate.new.apply(Qubit['+'], 0)
    end

    test 'S|-> = |-i>' do
      assert_equal Qubit['-i'], SGate.new.apply(Qubit['-'], 0)
    end

    test 'S|i> = |->' do
      assert_equal Qubit['-'], SGate.new.apply(Qubit['i'], 0)
    end

    test 'S|-i> = |+>' do
      assert_equal Qubit['+'], SGate.new.apply(Qubit['-i'], 0)
    end
  end
end
