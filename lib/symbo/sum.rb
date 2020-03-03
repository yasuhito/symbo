# frozen_string_literal: true

require 'symbo/expression'
require 'symbo/factorial'
require 'symbo/function'
require 'symbo/mergeable'
require 'symbo/product'

module Symbo
  # シンボリックな和
  class Sum < Expression
    include Mergeable

    using Symbo

    # :section: Power Transformation Methods

    # べき乗の低
    #
    #   (:x + :y).base # => :x + :y
    def base
      dup
    end

    # べき指数
    #
    #   (:x + :y).exponent # => 1
    def exponent
      1
    end

    # :section: Basic Distributive Transformation Methods

    # 同類項の項部分
    #
    #   (:x + :y).term # => Product[:x + :y]
    def term
      Product[self]
    end

    # 同類項の定数部分
    #
    #   (:x + :y).const # => 1
    def const
      1
    end

    # :section: Order Relation Methods

    # 交換法則によるオペランド並べ替えに使う順序関係
    #
    # - 相手が和の場合
    # 最右のオペランドから順に compare していき、異なるものがあればそれで順序を決定する。
    # どちらかのオペランドがなくなれば、短いほうが左側。
    #
    #   (:a + :b).compare(:a + :c) # => true
    #   Sum[:a, :c, :d].compare(Sum[:b, :c, :d]) # => true
    #   (:c + :d).compare(Sum[:b, :c, :d]) # => true
    #
    # - 階乗、関数、シンボルの場合
    # 相手を単項の和にして比較
    #
    #   (1 + :x).compare(:y) # => true
    #
    # - それ以外の場合
    # 次のルールで比較
    #
    #   !other.compare(self)
    #
    # rubocop:disable Metrics/CyclomaticComplexity
    def compare(other)
      case other
      when Sum
        return @operands.last.compare(other.operands.last) if @operands.last != other.operands.last

        m = length
        n = other.length
        if [m, n].min >= 2
          1.upto([m, n].min) do |j|
            return operand(m - j).compare(other.operand(n - j)) if operand(m - j) != other.operand(n - j)
          end
        end
        m < n
      when Factorial, Function, Symbol
        compare Sum[other]
      else
        !other.compare(self)
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity

    # :section:

    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Metrics/CyclomaticComplexity
    def evaluate
      v = @operands[0].evaluate
      w = @operands[1].evaluate

      if (v.integer? || v.complex?) && (w.integer? || w.complex?)
        v.plus w
      elsif v.constant? && w.constant?
        Fraction[Sum[Product[v.numerator, w.denominator].evaluate, Product[w.numerator, v.denominator].evaluate].evaluate,
                 Product[v.denominator, w.denominator].evaluate].evaluate
      else
        Sum[v.simplify, w.simplify]
      end
    end
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/CyclomaticComplexity

    def simplify_rational_number
      self
    end

    def to_s
      elements = @operands.map do |each|
        case each
        when Sum
          if each.length > 1
            [' + ', "(#{each})"]
          else
            [' + ', each.to_s]
          end
        when Product
          if each.length > 1 && each.operand(0) == -1
            [' - ', Product[*each.operands[1..-1]].to_s]
          else
            [' + ', each.to_s]
          end
        else
          [' + ', each.to_s]
        end
      end
      elements.flatten[1..-1].join
    end

    protected

    def _simplify
      return UNDEFINED if @operands.include?(UNDEFINED)
      return operand(0) if length == 1

      v = simplify_rec(@operands)
      if v.size == 1
        v[0]
      elsif v.size > 1
        Sum[*v]
      else
        0
      end
    end

    private

    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Metrics/CyclomaticComplexity
    def simplify_rec(l) # rubocop:disable Naming/MethodParameterName
      case l
      in Constant, Constant
        p = Sum[*l].simplify_rne
        p.zero? ? [] : [p]
      in u1, u2 if u1.zero? && !u2.sum?
        [u2]
      in u1, u2 if u2.zero? && !u1.sum?
        [u1]
      in u1, u2 if l.none?(:sum?) && u1.term == u2.term
        s = Sum[u1.const, u2.const].simplify
        p = Product[u1.term, s].simplify
        p.zero? ? [] : [p]
      in u1, u2 if l.none?(&:sum?) && u2.compare(u1)
        [u2, u1]
      in _, _ if l.none?(&:sum?)
        l
      in Sum => u1, Sum => u2
        merge u1.operands, u2.operands
      in Sum => u1, u2
        merge u1.operands, [u2]
      in u1, Sum => u2
        merge [u1], u2.operands
      in Sum => u1, *rest
        merge u1.operands, simplify_rec(rest)
      in u1, *rest
        merge [u1], simplify_rec(rest)
      end
    end
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/CyclomaticComplexity

    # rubocop:disable Metrics/PerceivedComplexity
    def simplify_rne_rec
      if length == 1
        v = operand(0).simplify_rne_rec
        if v.undefined?
          UNDEFINED
        else
          v
        end
      elsif length == 2
        v = operand(0).simplify_rne_rec
        w = operand(1).simplify_rne_rec
        if v.undefined? || w.undefined?
          UNDEFINED
        else
          Sum[v, w].evaluate
        end
      end
    end
    # rubocop:enable Metrics/PerceivedComplexity
  end
end
