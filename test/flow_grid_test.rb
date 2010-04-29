require "#{File.dirname(__FILE__)}/test_helper"
class FlowGridTest <  ActiveSupport::TestCase
  class TestHelper 
    include FlowGridHelper
  end

  test "should render the collection" do
    collection = ['foo','bar','baz']
    helper = TestHelper.new
    helper.flow_grid(collection, 'month')
  end
  
  test "the truth" do
    assert true
  end
  # 
  test "the untruth" do
    assert false
  end
  
end
