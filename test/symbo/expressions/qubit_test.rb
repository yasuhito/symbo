# frozen_string_literal: true

require 'test_helper'

require 'symbo'

module Symbo
  class QubitTest < ActiveSupport::TestCase
    using Symbo

    test 'convert to bra vector' do
      bra = Qubit[1 + 2i, 2 + 1i].bra

      assert_equal 1, bra.row_size
      assert_equal 2, bra.column_size
      assert_equal 1 - 2i, bra[0, 0]
      assert_equal 2 - 1i, bra[0, 1]
    end

    test 'inner product' do
      ket1 = Qubit[1 + 2i, 2 - 1i].bra
      ket2 = Qubit[1 + 2i, 2 + 1i]

      assert_equal Complex(8, 4), (ket1 * ket2)[0, 0]
    end

    test "Qubit['0'] in a ket string" do
      assert_equal '|0⟩', Qubit['0'].to_s
    end

    test "Qubit['1'] in a ket string" do
      assert_equal '|1⟩', Qubit['1'].to_s
    end

    test "Qubit['00'] in a ket string" do
      assert_equal '|00⟩', Qubit['00'].to_s
    end

    test "Qubit['01'] in a ket string" do
      assert_equal '|01⟩', Qubit['01'].to_s
    end

    test "Qubit['10'] in a ket string" do
      assert_equal '|10⟩', Qubit['10'].to_s
    end

    test "Qubit['11'] in a ket string" do
      assert_equal '|11⟩', Qubit['11'].to_s
    end

    test "Qubit['101'] in a ket string" do
      assert_equal '|101⟩', Qubit['101'].to_s
    end

    test "Qubits' state in a String" do
      assert_equal 'α|0⟩ + β|1⟩', (:α * Qubit['0'] + :β * Qubit['1']).to_s
    end
  end
end
