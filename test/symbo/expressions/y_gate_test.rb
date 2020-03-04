# frozen_string_literal: true

require 'test_helper'

module Symbo
  class YGateTest < ActiveSupport::TestCase
    using Symbo

    test 'Y|0> = i|1>' do
      assert_equal 1i * Qubit['1'], YGate.new.apply(Qubit['0'], 0)
    end

    test 'Y|1> = -i|0>' do
      assert_equal(-1i * Qubit['0'], YGate.new.apply(Qubit['1'], 0))
    end

    test 'Y|+> = -i|->' do
      assert_equal(-1i * Qubit['-'], YGate.new.apply(Qubit['+'], 0))
    end

    test 'Y|-> = i|+>' do
      assert_equal 1i * Qubit['+'], YGate.new.apply(Qubit['-'], 0)
    end

    test 'Y|i> = |i>' do
      assert_equal Qubit['i'], YGate.new.apply(Qubit['i'], 0)
    end

    test 'Y|-i> = -|-i>' do
      assert_equal(-Qubit['-i'], YGate.new.apply(Qubit['-i'], 0))
    end
  end
end
