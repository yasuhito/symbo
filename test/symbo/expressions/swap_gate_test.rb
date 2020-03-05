# frozen_string_literal: true

require 'test_helper'

require 'symbo'

module Symbo
  class SwapGateTest < ActiveSupport::TestCase
    using Symbo
    include Symbo

    test 'SWAP(0, 1)|00> = |00>' do
      assert_equal Qubit['00'], Swap(0, 1, length: 2) * Qubit['00']
    end

    test 'SWAP(0, 1)|01> = |10>' do
      assert_equal Qubit['10'], Swap(0, 1, length: 2) * Qubit['01']
    end

    test 'SWAP(0, 1)|10> = |01>' do
      assert_equal Qubit['01'], Swap(0, 1, length: 2) * Qubit['10']
    end

    test 'SWAP(0, 1)|11> = |11>' do
      assert_equal Qubit['11'], Swap(0, 1, length: 2) * Qubit['11']
    end

    test 'SWAP(0, 1)|001> = |100>' do
      assert_equal Qubit['100'], Swap(0, 2, length: 3) * Qubit['001']
    end
  end
end
