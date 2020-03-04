# frozen_string_literal: true

require 'test_helper'

module Symbo
  class SwapGateTest < ActiveSupport::TestCase
    test 'SWAP(0, 1)|00> = |00>' do
      assert_equal Qubit['00'], SwapGate.new.apply(Qubit['00'], 0, 1)
    end

    test 'SWAP(0, 1)|01> = |10>' do
      assert_equal Qubit['10'], SwapGate.new.apply(Qubit['01'], 0, 1)
    end

    test 'SWAP(0, 1)|10> = |01>' do
      assert_equal Qubit['01'], SwapGate.new.apply(Qubit['10'], 0, 1)
    end

    test 'SWAP(0, 1)|11> = |11>' do
      assert_equal Qubit['11'], SwapGate.new.apply(Qubit['11'], 0, 1)
    end
  end
end
