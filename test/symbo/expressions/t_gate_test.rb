# frozen_string_literal: true

require 'test_helper'

module Symbo
  class TGateTest < ActiveSupport::TestCase
    using Symbo

    test 'T|0> = |0>' do
      assert_equal Qubit['0'], TGate.new.apply(Qubit['0'], 0)
    end

    test 'T|1> = e^{iπ/4}|1>' do
      assert_equal E**(1i * PI/4) * Qubit['1'], TGate.new.apply(Qubit['1'], 0)
    end
  end
end
