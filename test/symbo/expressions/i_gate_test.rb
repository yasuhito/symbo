# frozen_string_literal: true

require 'test_helper'

require 'symbo'

module Symbo
  class IGateTest < ActiveSupport::TestCase
    using Symbo

    test 'I|0> = |0>' do
      assert_equal Qubit['0'], I * Qubit['0']
    end

    test 'I|1> = |1>' do
      assert_equal Qubit['1'], I * Qubit['1']
    end

    test 'I⊗I|00> = |00' do
      assert_equal Qubit['00'], TensorProduct[I, I] * Qubit['00']
    end
  end
end
