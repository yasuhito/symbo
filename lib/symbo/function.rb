# frozen_string_literal: true

require 'symbo/expression'
require 'symbo/integer'
require 'symbo/symbol'

module Symbo
  class Function < Expression
    include Symbo

    using Symbo

    def name
      @operands[0]
    end

    def parameters
      @operands[1..-1]
    end

    # :section: Power Transformation Methods

    # べき乗の低
    #
    #   Function(:f, :x).base # => Function(:f, :x)
    def base
      dup
    end

    # べき指数
    #
    #   Function(:f, :x).exponent # => 1
    def exponent
      1
    end

    # :section: Basic Distributive Transformation Methods

    # 同類項の項部分
    #
    #   Function(:f, :x).term # => Product(Function(:f, :x))
    def term
      Product[self]
    end

    # 同類項の定数部分
    #
    #   Function(:f, :x).const # => 1
    def const
      1
    end

    # :section: Order Relation Methods

    # 交換法則によるオペランド並べ替えに使う順序関係
    #
    # - 相手が関数の場合
    # 関数名が異なる場合、関数名で順序を決定。
    #
    #   Function(:f, :x).compare(Function(:g, :x)) # => true
    #
    # 関数名が同じの場合、関数の最左のオペランドから順に compare していき、
    # 異なるものがあればそれで順序を決定する。
    #
    #   Function(:f, :x).compare(Function(:f, :y)) # => true
    #
    # どちらかのオペランドがなくなれば、短いほうが左側。
    #
    #   Function(:g, :x).compare(Function(:g, :x, :y)) # => true
    #
    # - シンボルの場合
    # 関数名とシンボルが等しい場合 false
    #
    #   Function(:f, :x).compare(:f) # => false
    #
    # 異なる場合、関数名とシンボルで比較
    #
    #   Function(:f, :x).compare(:g) # => true
    #
    # - それ以外の場合
    # 次のルールで比較
    #
    #   !other.compare(self)
    #
    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Metrics/CyclomaticComplexity
    # rubocop:disable Metrics/AbcSize
    def compare(other)
      case other
      when Function
        if name != other.name
          name.compare other.name
        else
          return parameters.first.compare other.parameters.first if parameters.first != other.parameters.first

          m = parameters.length
          n = other.parameters.length
          0.upto([m, n].min - 2) do |j|
            return parameters[j + 1].compare(other.parameters[j + 1]) if (parameters[j] == other.parameters[j]) && (parameters[j + 1] != other.parameters[j + 1])
          end

          m.compare(n)
        end
      when Symbol
        if name == other
          false
        else
          name.compare other
        end
      else
        !other.compare(self)
      end
    end
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/CyclomaticComplexity
    # rubocop:enable Metrics/AbcSize
  end
end
