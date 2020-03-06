# frozen_string_literal: true

require 'matrix'

module Symbo
  class Qubit < Matrix
    include Symbo
    extend Symbo

    using Symbo

    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Metrics/CyclomaticComplexity
    # rubocop:disable Metrics/AbcSize
    def self.[](*state_or_value)
      rows =
        case state_or_value
        in [String => bits] if /\A[0|1]+\Z/=~ bits
          m = bits.split(//).inject(Matrix[[1]]) do |result, string|
            each = case string
                   when '0'
                     Matrix[[1], [0]]
                   when '1'
                     Matrix[[0], [1]]
                   end
            TensorProduct[result, each]
          end
          m.map(&:simplify).to_a
        in [String => bit]
          elms = case bit
                 when '0'
                   [1, 0]
                 when '1'
                   [0, 1]
                 when '+'
                   [1/√(2), 1/√(2)]
                 when '-'
                   [1/√(2), -1/√(2)]
                 when 'i'
                   [1/√(2), 1i/√(2)]
                 when '-i'
                   [1/√(2), -1i/√(2)]
                 else
                   raise "Invalid qubit state: #{bit}"
                 end
          elms.map { |each| [each.simplify] }
        else
          state_or_value.map { |each| [each.simplify] }
        end

      super(*rows)
    end
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/CyclomaticComplexity
    # rubocop:enable Metrics/AbcSize

    def -@
      map { |each| Product[-1, each].simplify }
    end

    def +(other)
      super(other).map(&:simplify)
    end

    def -(other)
      raise unless other.is_a?(Qubit) && row_size == other.row_size

      rows = (0...row_size).map do |each|
        Sum[self[each, 0], Product[-1, other[each, 0]]].simplify
      end
      Qubit[*rows]
    end

    def bra
      map(&:conjugate).t
    end

    def ket
      self
    end

    def state
      map(&:simplify)
    end

    def ==(other)
      super other.simplify
    end

    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Metrics/CyclomaticComplexity
    # rubocop:disable Metrics/AbcSize
    def to_s
      kets = []
      ket_length = Math.log2(row_size).to_i

      (0...row_size).each do |each|
        x = self[each, 0]
        kets << [x, "|%0*b⟩" % [ket_length, each]] unless x.zero?
      end

      kets.inject('') do |result, each|
        coefficient = if each[0] == 1
                        ''
                      elsif each[0].constant? || each[0].symbol? || each[0].power?
                        each[0].to_s
                      elsif !each[0].product? && each[0].length > 1
                        "(#{each[0]})"
                      elsif each[0].product? && each[0].operand(0) != -1
                        each[0].to_s
                      elsif each[0].product? && each[0].operand(0) == -1
                        each[0].to_s
                      end

        result += if result.empty?
                    "#{coefficient}#{each[1]}"
                  elsif coefficient.to_s[0] != '-'
                    " + #{coefficient}#{each[1]}"
                  else
                    " - #{coefficient.to_s[1..-1]}#{each[1]}"
                  end
      end
    end
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/CyclomaticComplexity
    # rubocop:enable Metrics/AbcSize
  end
end
