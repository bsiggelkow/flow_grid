require "#{File.dirname(__FILE__)}/test_helper"
require 'action_view'

class TestHelper < ActionView::Base
  include FlowGridHelper
  include ActionView::Helpers::TagHelper
  # stub render
  def render(opts={})
    opts[:object]
  end
end

class FlowGridTest <  ActiveSupport::TestCase
  
  def setup
    @helper = TestHelper.new
    @collection = ['foo','bar','baz']
  end

  test "should render the collection in a table" do
    html = %Q{
      <table class="flow_grid"><tr><td>foo</td></tr><tr><td>bar</td></tr><tr><td>baz</td></tr></table>
    }
    assert_equal html.strip, @helper.flow_grid(@collection, :partial => 'item')
  end

  test "should convert the collection item to a string" do
    collection = [1,2,3]
    html = %Q{
      <table class="flow_grid"><tr><td>1</td></tr><tr><td>2</td></tr><tr><td>3</td></tr></table>
    }
    assert_equal html.strip, @helper.flow_grid(collection)
  end

  test "should flow the values vertically" do
    html = %Q{
      <table class="flow_grid"><tr><td>foo</td><td>baz</td></tr><tr><td>bar</td><td>&nbsp;</td></tr></table>
    }
    assert_equal html.strip, @helper.flow_grid(@collection, :columns => 2, :flow => :vertical )
  end

  test "should render the partial for the collection" do
    @collection.each do |item|
      @helper.expects(:render).with({:partial => 'item', :object => item}).returns(item)
    end
    @helper.flow_grid(@collection, :partial => 'item')
  end
  
  test 'should call the block' do
    html = %Q{
      <table class="flow_grid"><tr><td>oof</td></tr><tr><td>rab</td></tr><tr><td>zab</td></tr></table>
    }
    res = @helper.flow_grid(@collection) {|t| t.reverse}
    assert_equal html.strip, res
  end
  
end
