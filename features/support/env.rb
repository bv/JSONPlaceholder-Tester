require 'rest-client'
require 'json'
require 'minitest/spec'

#
# Here are the initializations required in order to
# use assertion in step definitions
#
class MinitestWorld
  include Minitest::Assertions
  attr_accessor :assertions

  def initialize
    self.assertions = 0
  end
end

World do
  MinitestWorld.new
end

World(MiniTest::Assertions)