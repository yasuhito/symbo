# frozen_string_literal: true

require 'symbo/expressions/gate'

module Symbo
  class RzGate < Gate
    using Symbo

    def initialize(theta)
      @theta = theta
    end

    def matrix
      Matrix[[E**(-1i*@theta/2), 0],
             [0,                 E**(1i*@theta/2)]]
    end
  end

  def Rz(theta) # rubocop:disable Naming/MethodName
    RzGate.new(theta).matrix
  end
end
