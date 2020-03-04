# frozen_string_literal: true

require 'symbo/concerns/mergeable'
require 'symbo/expression'
require 'symbo/power'

module Symbo
  class Product < Expression
    include Mergeable

    using Symbo

    # :section: Power Transformation Methods

    # べき乗の低
    #
    #   (:x * :y).base # => :x * :y
    def base
      dup
    end

    # べき指数
    #
    #   (:x * :y).exponent # => 1
    def exponent
      1
    end

    # :section: Basic Distributive Transformation Methods

    # 同類項の項部分
    #
    #   Product[2, :x, :y, :z].term # => Product[:x, :y, :z]
    #   Product[1/3, :x, :y, :z].term # => Product[:x, :y, :z]
    #   Product[:x, :y, :z].term # => Product[:x, :y, :z]
    def term
      if @operands.first.constant?
        Product.new(*@operands[1..-1])
      else
        self
      end
    end

    # 同類項の定数部分
    #
    #   Product[2, :x, :y, :z].const # => 2
    #   Product[1/3, :x, :y, :z].const # => 1/3
    #   Product[:x, :y, :z].const # => 1
    def const
      if @operands.first.constant?
        @operands.first
      else
        1
      end
    end

    # :section: Order Relation Methods

    # 交換法則によるオペランド並べ替えに使う順序関係
    #
    # - 相手が積の場合
    # 最右のオペランドから順に compare していき、異なるものがあればそれで順序を決定する。
    #
    #   (:a * :b).compare(:a * :c) # => true
    #   Product[:a, :c, :d].compare(Product[:b, :c, :d]) # => true
    #
    # どちらかのオペランドがなくなれば、短いほうが左側。
    #
    #   (:c * :d).compare(Product[:b, :c, :d]) # => true
    #
    # - べき乗、和、階乗、関数、シンボルの場合
    # 相手を単項の積にして比較
    #
    #   (:a * (:x**2)).compare(:x**3) # => true
    #
    # - それ以外の場合
    # 次のルールで比較
    #
    #   !other.compare(self)
    #
    # rubocop:disable Metrics/CyclomaticComplexity
    def compare(other)
      case other
      when Product
        return @operands.last.compare(other.operands.last) if @operands.last != other.operands.last

        m = length
        n = other.length
        if [m, n].min >= 2
          1.upto([m, n].min) do |j|
            return operand(m - j).compare(other.operand(n - j)) if operand(m - j) != other.operand(n - j)
          end
        end
        m < n
      when Power, Sum, Factorial, Function, Symbol
        compare Product[other]
      else
        !other.compare(self)
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity

    # :section:

    # v * w
    #
    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Metrics/CyclomaticComplexity
    def evaluate
      v = operand(0)
      w = operand(1)

      if (v.integer? || v.complex?) && (w.integer? || w.complex?)
        v.mult w
      elsif v.constant? && w.constant?
        Fraction[Product[v.numerator, w.numerator].simplify,
                 Product[v.denominator, w.denominator].simplify].evaluate
      else
        Product[v.simplify, w.simplify]
      end
    end
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/CyclomaticComplexity

    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Metrics/CyclomaticComplexity
    def to_s
      return "-#{operand(1)}" if length == 2 && operand(0) == -1

      @operands.map do |each|
        case each
        when Sum
          "(#{each})"
        when Product
          if each.length == 2 && each.operand(0) == -1
            "(-#{each.operand(1)})"
          elsif each.length > 1
            "(#{each})"
          else
            each.to_s
          end
        else
          each.to_s
        end
      end.join('*')
    end
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/CyclomaticComplexity

    protected

    def _simplify
      return UNDEFINED if @operands.any?(&:undefined?)
      return 0 if @operands.any?(&:zero?)
      return operand(0) if length == 1

      v = simplify_rec(@operands)
      if v.size == 1
        v[0]
      elsif v.size > 1
        Product[*v]
      else
        1
      end
    end

    private

    # l = [u1, u2,...,un] is a non-empty list with n ≥ 2 non-zero ASAEs.
    # Returns a list with zero or more operands that satisfy the condition of
    # ASAE-4.
    #
    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Metrics/CyclomaticComplexity
    def simplify_rec(l) # rubocop:disable Naming/MethodParameterName
      case l
      in Constant, Constant # SPRDREC-1-1
        p = Product[*l].simplify_rne
        p == 1 ? [] : [p]
      in 1, u2 unless u2.product? # SPRDREC-1-2
        [u2]
      in u1, 1 unless u1.product?
        [u1]
      in u1, u2 if l.none?(:product?) && u1.base == u2.base # SPRDREC-1-3
        s = Sum[u1.exponent, u2.exponent].simplify
        p = Power[u1.base, s].simplify
        p == 1 ? [] : [p]
      in u1, u2 if l.none?(&:product?) && u2.compare(u1) # SPRDREC-1-4
        [u2, u1]
      in _, _ if l.none?(&:product?) # SPRDREC-1-5
        l
      in Product => u1, Product => u2 # SPRDREC-2-1
        merge u1.operands, u2.operands
      in Product => u1, u2 # SPRDREC-2-2
        merge u1.operands, [u2]
      in u1, Product => u2 # SPRDREC-2-3
        merge [u1], u2.operands
      in Product => u1, *rest # SPRDREC-3-1
        merge u1.operands, simplify_rec(rest)
      in u1, *rest # SPRDREC-3-2
        merge [u1], simplify_rec(rest)
      end
    end
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/CyclomaticComplexity

    def simplify_rne_rec
      v = operand(0).simplify_rne_rec
      w = operand(1).simplify_rne_rec

      if v.undefined? || w.undefined?
        UNDEFINED
      else
        Product[v, w].evaluate
      end
    end
  end
end
