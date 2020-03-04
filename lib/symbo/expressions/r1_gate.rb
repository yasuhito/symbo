# frozen_string_literal: true

require 'symbo/expressions/e'

module Symbo
  class R1Gate < Gate
    using Symbo

    def initialize(theta)
      @theta = theta
    end

    def matrix
      Matrix[[1, 0],
             [0, E**(1i * @theta)]]
    end
  end
end
