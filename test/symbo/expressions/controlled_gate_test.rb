# frozen_string_literal: true

require 'test_helper'

require 'symbo'

module Symbo
  class CircuitTest < ActiveSupport::TestCase
    using Symbo
    include Symbo

    test 'Controlled(Rx(2π))0→1|00> = |00>' do
      assert_equal Qubit['00'], Controlled(Rx(2 * PI), 2, 0 => 1) * Qubit['00']
    end

    test 'Controlled(Rx(2π))0→1|01> = |01>' do
      assert_equal Qubit['01'], Controlled(Rx(2 * PI), 2, 0 => 1) * Qubit['01']
    end

    test 'Controlled(Rx(2π))0→1|10> = -|10>' do
      assert_equal(-Qubit['10'], Controlled(Rx(2 * PI), 2, 0 => 1) * Qubit['10'])
    end

    test 'Controlled(Rx(2π))0→1|11> = -|11>' do
      assert_equal(-Qubit['11'], Controlled(Rx(2 * PI), 2, 0 => 1) * Qubit['11'])
    end

    test 'Controlled(Ry(2π))0→1|00> = |00>' do
      assert_equal Qubit['00'], Controlled(Ry(2 * PI), 2, 0 => 1) * Qubit['00']
    end

    test 'Controlled(Ry(2π))0→1|01> = |01>' do
      assert_equal Qubit['01'], Controlled(Ry(2 * PI), 2, 0 => 1) * Qubit['01']
    end

    test 'Controlled(Ry(2π))0→1|10> = -|10>' do
      assert_equal(-Qubit['10'], Controlled(Ry(2 * PI), 2, 0 => 1) * Qubit['10'])
    end

    test 'Controlled(Ry(2π))0→1|11> = -|11>' do
      assert_equal(-Qubit['11'], Controlled(Ry(2 * PI), 2, 0 => 1) * Qubit['11'])
    end

    test 'Controlled(Rz(2π))0→1|00> = |00>' do
      assert_equal Qubit['00'], Controlled(Rz(2 * PI), 2, 0 => 1) * Qubit['00']
    end

    test 'Controlled(Rz(2π))0→1|01> = |01>' do
      assert_equal Qubit['01'], Controlled(Rz(2 * PI), 2, 0 => 1) * Qubit['01']
    end

    test 'Controlled(Rz(2π))0→1|10> = -|10>' do
      assert_equal(-Qubit['10'], Controlled(Rz(2 * PI), 2, 0 => 1) * Qubit['10'])
    end

    test 'Controlled(Rz(2π))0→1|11> = -|11>' do
      assert_equal(-Qubit['11'], Controlled(Rz(2 * PI), 2, 0 => 1) * Qubit['11'])
    end

    test 'Controlled(R1(2π))0→1|00> = |00>' do
      assert_equal Qubit['00'], Controlled(R1(2 * PI), 2, 0 => 1) * Qubit['00']
    end

    test 'Controlled(R1(2π))0→1|01> = |01>' do
      assert_equal Qubit['01'], Controlled(R1(2 * PI), 2, 0 => 1) * Qubit['01']
    end

    test 'Controlled(R1(2π))0→1|10> = |10>' do
      assert_equal Qubit['10'], Controlled(R1(2 * PI), 2, 0 => 1) * Qubit['10']
    end

    test 'Controlled(R1(2π))0→1|11> = |11>' do
      assert_equal Qubit['11'], Controlled(R1(2 * PI), 2, 0 => 1) * Qubit['11']
    end
  end
end
