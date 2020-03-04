# frozen_string_literal: true

require 'symbo/expressions/gate'

module Symbo
  class SGate < Gate
    def matrix
      Matrix[[1, 0], [0, 1i]]
    end
  end
end
