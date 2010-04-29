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
    assert_equal html.strip, @helper.flow_grid(@collection, 'item')
  end

  test "should render the partial for the collection" do
    @collection.each do |item|
      @helper.expects(:render).with({:partial => 'item', :object => item}).returns(item)
    end
    @helper.flow_grid(@collection, 'item')
  end
  
end
