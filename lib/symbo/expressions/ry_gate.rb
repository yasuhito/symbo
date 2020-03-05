# frozen_string_literal: true

require 'symbo/expressions/cos'
require 'symbo/expressions/gate'

module Symbo
  class RyGate < Gate
    using Symbo

    def initialize(theta)
      @theta = theta
    end

    def matrix
      Matrix[[Cos[@theta/2], -Sin[@theta/2]],
             [Sin[@theta/2], Cos[@theta/2]]]
    end
  end

  def Ry(theta) # rubocop:disable Naming/MethodName
    RyGate.new(theta).matrix
  end
end
