# frozen_string_literal: true

require 'test_helper'

require 'symbo/pi'
require 'symbo/product'

module Symbo
  class PiTest < ActiveSupport::TestCase
    test 'π·2 → 2·π' do
      assert_equal Product[2, PI], Product[PI, 2].simplify
    end

    test 'x·π → π·x' do
      assert_equal Product[PI, :x], Product[:x, PI].simplify
    end
  end
end
