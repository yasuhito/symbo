# frozen_string_literal: true

require 'symbo/algebraic_operators'
require 'symbo/integer'
require 'symbo/relational_operators'
require 'symbo/symbol'

module Symbo
  UNDEFINED = :undefined

  # General expression interface
  class Expression
    using Symbo

    include AlgebraicOperators
    include ExpressionType
    include RelationalOperators

    attr_reader :operands

    def self.[](*operands)
      new(*operands)
    end

    def initialize(*operands)
      @operands = operands
    end

    # :section: Simplification Methods

    def simplify
      self.class.new(*@operands.map(&:simplify))._simplify
    end

    # :section: Power Transformation Methods
    #
    # 自動簡約式 u のべき乗変形に使うオペレータ。
    #
    #   u^v·u^w = u^{v+w}
    #

    # べき乗の低
    def base
      raise NotImplementedError, "#{self.class}#base"
    end

    # べき指数
    #
    # べき指数を書かない b のような式では exponent → 1 を返すことで、
    #
    #   b·b^2 = b^3
    #
    # のような式変形を簡単にする。
    def exponent
      raise NotImplementedError
    end

    # :section: Basic Distributive Transformation Methods
    #
    # 同類項のまとめに使うオペレータ。
    #
    #   v·u + w·u = (v+w)u
    #

    # 同類項の項部分
    #
    # 返り値は Product または UNDEFINED になる。返り値が単項の積 ·u の場合があるが、
    # これは x と 2x の term を取ったときにどちらも同じ ·x を返すようにするための工夫。
    def term
      raise NotImplementedError, "#{self.class}#term"
    end

    # 同類項の定数部分
    def const
      raise NotImplementedError
    end

    # :section: Order Relation Methods

    # 交換法則によるオペランド並べ替えに使う順序関係
    def compare(_other)
      raise NotImplementedError, "#{self.class}#compare"
    end

    # :section: Operand Methods

    # Returns nth operand
    def operand(n) # rubocop:disable Naming/MethodParameterName
      @operands[n]
    end

    # Returns the number of operands
    def length
      @operands.length
    end

    protected

    # :category: Simplification Methods

    def _simplify
      raise NotImplementedError
    end

    def simplify_rne
      v = simplify_rne_rec
      if v == UNDEFINED
        UNDEFINED
      else
        v.simplify_rational_number
      end
    end
  end
end
