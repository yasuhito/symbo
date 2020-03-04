# frozen_string_literal: true

require 'test_helper'

module Symbo
  class CircuitTest < ActiveSupport::TestCase
    using Symbo

    test 'Controlled(Rx(2π), 1, control: 0)|00>' do
      assert_equal Qubit['00'], ControlledGate.new(RxGate.new(2 * PI)).apply(Qubit['00'], 1, 0)
    end

    test 'Controlled(Rx(2π), 1, control: 0)|01>' do
      assert_equal Qubit['01'], ControlledGate.new(RxGate.new(2 * PI)).apply(Qubit['01'], 1, 0)
    end

    test 'Controlled(Rx(2π), 1, control: 0)|10>' do
      assert_equal(-Qubit['10'], ControlledGate.new(RxGate.new(2 * PI)).apply(Qubit['10'], 1, 0))
    end

    test 'Controlled(Rx(2π), 1, control: 0)|11>' do
      assert_equal(-Qubit['11'], ControlledGate.new(RxGate.new(2 * PI)).apply(Qubit['11'], 1, 0))
    end

    test 'Controlled(Ry(2π), 1, control: 0)|00>' do
      assert_equal Qubit['00'], ControlledGate.new(RyGate.new(2 * PI)).apply(Qubit['00'], 1, 0)
    end

    test 'Controlled(Ry(2π), 1, control: 0)|01>' do
      assert_equal Qubit['01'], ControlledGate.new(RyGate.new(2 * PI)).apply(Qubit['01'], 1, 0)
    end

    test 'Controlled(Ry(2π), 1, control: 0)|10>' do
      assert_equal(-Qubit['10'], ControlledGate.new(RyGate.new(2 * PI)).apply(Qubit['10'], 1, 0))
    end

    test 'Controlled(Ry(2π), 1, control: 0)|11>' do
      assert_equal(-Qubit['11'], ControlledGate.new(RyGate.new(2 * PI)).apply(Qubit['11'], 1, 0))
    end

    test 'Controlled(Rz(2π), 1, control: 0)|00>' do
      assert_equal Qubit['00'], ControlledGate.new(RzGate.new(2 * PI)).apply(Qubit['00'], 1, 0)
    end

    test 'Controlled(Rz(2π), 1, control: 0)|01>' do
      assert_equal Qubit['01'], ControlledGate.new(RzGate.new(2 * PI)).apply(Qubit['01'], 1, 0)
    end

    test 'Controlled(Rz(2π), 1, control: 0)|10>' do
      assert_equal(-Qubit['10'], ControlledGate.new(RzGate.new(2 * PI)).apply(Qubit['10'], 1, 0))
    end

    test 'Controlled(Rz(2π), 1, control: 0)|11>' do
      assert_equal(-Qubit['11'], ControlledGate.new(RzGate.new(2 * PI)).apply(Qubit['11'], 1, 0))
    end

    test 'Controlled(R1(2π), 1, control: 0)|00>' do
      assert_equal Qubit['00'], ControlledGate.new(R1Gate.new(2 * PI)).apply(Qubit['00'], 1, 0)
    end

    test 'Controlled(R1(2π), 1, control: 0)|01>' do
      assert_equal Qubit['01'], ControlledGate.new(R1Gate.new(2 * PI)).apply(Qubit['01'], 1, 0)
    end

    test 'Controlled(R1(2π), 1, control: 0)|10>' do
      assert_equal Qubit['10'], ControlledGate.new(R1Gate.new(2 * PI)).apply(Qubit['10'], 1, 0)
    end

    test 'Controlled(R1(2π), 1, control: 0)|11>' do
      assert_equal Qubit['11'], ControlledGate.new(R1Gate.new(2 * PI)).apply(Qubit['11'], 1, 0)
    end
  end
end
