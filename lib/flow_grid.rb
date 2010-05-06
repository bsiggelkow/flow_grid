require 'active_support/core_ext'
# FlowGrid
module FlowGridHelper
  # Renders an HTML table by looping over the items and creating a table cell for each item.
  # The content of the cell can be rendered by passing the item to the partial.
  # If a block is given, it acts as a transformer for the collection item. If a partial is specified
  # along with the block, then the transformation will be performed before passing the item to the partial.
  # You can specify the number of columns that the table will have, and if the columns
  # should be laid down horizontally across or vertically down. A &nbsp; will be inserted
  # into any extra cells.
  # Options supported:
  # * :partial => partial to render (passed to <code>render</code> so do not preface with _)
  # * :columns => number of columns for the grid (defaults to 1)
  # * :flow    => dictates if the values will flow horizontal or vertical (defaults to horizontal)
  # * :fill    => fill grid cell with this if collection item is nil (defaults to '&nbsp;')
  # Any remaining options will be treated as html options for the generated <code>table</code> tag
  def flow_grid(collection, options={}, &block)

    partial     = options.delete(:partial)
    columns     = options.delete(:columns) || 1
    flow        = options.delete(:flow) || :horizontal
    fill        = options.delete(:fill) || '&nbsp;'
    
    table_options = {:class => :flow_grid}.update(options.stringify_keys)
    rows = (collection.length.to_f / columns.to_f).ceil
    i = 0 # item counter
    j = -1 # row counter (used for vertical orientation)
    result = tag :table, table_options, true # create the <table> tag
    rows.times do
      j = j + 1
      i = j if flow == :vertical
      result.concat "<tr>"
      columns.times do
        result.concat "<td>"
        if collection[i]
          item = block_given? ? yield( collection[i] ) : collection[i]
          result.concat partial ? 
            render(:partial => partial, :object => item) :
            item.to_s
        else
          result.concat fill
        end       
        i = (flow == :horizontal ? i + 1 : i + rows)
        result.concat "</td>"
      end
      
      result.concat "</tr>"
    end
    result.concat "</table>"
  end
end