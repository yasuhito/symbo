# frozen_string_literal: true

require 'test_helper'

require 'symbo'

module Symbo
  class CcnotGateTest < ActiveSupport::TestCase
    using Symbo
    include Symbo

    test 'CCNOT (Toffoli) gate' do
      assert_equal :α * Qubit['000'] + :β * Qubit['001'] + :γ * Qubit['010'] + :δ * Qubit['011'] + :ϵ * Qubit['100'] + :ζ * Qubit['101'] + :η * Qubit['110'] + :θ * Qubit['111'],
                   Ccnot(3, [0, 1] => 2) * (:α * Qubit['000'] + :β * Qubit['001'] + :γ * Qubit['010'] + :δ * Qubit['011'] + :ϵ * Qubit['100'] + :ζ * Qubit['101'] + :θ * Qubit['110'] + :η * Qubit['111'])
    end
  end
end
