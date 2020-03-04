# frozen_string_literal: true

require 'symbo/integer'
require 'symbo/symbol'

module Symbo
  # シンボリックな階乗
  class Factorial < Expression
    using Symbo

    # :section: Power Transformation Methods

    # べき乗の低
    #
    #   Factorial[:x].base # => Factorial[:x]
    def base
      dup
    end

    # べき指数
    #
    #   Factorial[:x].exponent # => 1
    def exponent
      1
    end

    # :section: Basic Distributive Transformation Methods

    # 同類項の項部分
    #
    #   Factorial[:x].term # => Product[Factorial[:x]]
    def term
      Product[self]
    end

    # 同類項の定数部分
    #
    #   Factorial[:x].const # => 1
    def const
      1
    end

    # :section: Order Relation Methods

    # 交換法則によるオペランド並べ替えに使う順序関係
    #
    # - 相手が階乗の場合
    # オペランド同士を比較する
    #
    #   Factorial[:m].compare(:n) # => true
    #
    # - 関数またはシンボルの場合
    # 最初のオペランドが相手と同じ場合 false
    #
    #   Factorial[Function[:f, :x]].compare(Function[:f, :x]) # => false
    #   Factorial[:x].compare(:x) # => true
    #
    # 異なる場合、相手を階乗と見て比較
    #
    #   Factorial[:x].compare(Function[:f, :x]) # => true
    #
    # - それ以外の場合
    # 次のルールで比較
    #
    #   !other.compare(self)
    def compare(other)
      case other
      when Factorial
        @operands[0].compare other.operands[0]
      when Function, Symbol
        if @operands[0] == other
          false
        else
          compare Factorial[other]
        end
      else
        !other.compare(self)
      end
    end
  end
end
