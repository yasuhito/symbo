# frozen_string_literal: true

require 'test_helper'

module Symbo
  class ZGateTest < ActiveSupport::TestCase
    test 'Z|0> = |0>' do
      assert_equal Qubit['0'], ZGate.new.apply(Qubit['0'], 0)
    end

    test 'Z|1> = -|1>' do
      assert_equal(-Qubit['1'], ZGate.new.apply(Qubit['1'], 0))
    end

    test 'Z|+> = |->' do
      assert_equal Qubit['-'], ZGate.new.apply(Qubit['+'], 0)
    end

    test 'Z|-> = |+>' do
      assert_equal Qubit['+'], ZGate.new.apply(Qubit['-'], 0)
    end

    test 'Z|i> = |-i>' do
      assert_equal Qubit['-i'], ZGate.new.apply(Qubit['i'], 0)
    end

    test 'Z|-i> = |i>' do
      assert_equal Qubit['i'], ZGate.new.apply(Qubit['-i'], 0)
    end
  end
end
