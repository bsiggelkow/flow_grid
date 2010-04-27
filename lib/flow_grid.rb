# FlowGrid
module FlowGridHelper
  # Renders an HTML table by looping over the items and creating a table cell for each item.
  # The content of the cell is rendered by passing the item to the partial.
  # You can specify the number of columns that the table will have, and if the columns
  # should be laid down horizontally across or vertically down. A &nbsp; will be inserted
  # into any extra cells.
  def flow_grid(collection, partial, columns=1, orientation=:horizontal, options={})
    table_options = {:class => :flow_grid}.update(options.stringify_keys)
    rows = (collection.length.to_f / columns.to_f).ceil
    i = 0 # item counter
    j = -1 # row counter (used for vertical orientation)
    result = tag :table, table_options, true # create the <table> tag
    rows.times do
      j = j + 1
      i = j if orientation == :vertical
      result += "<tr>"
      columns.times do
        result += "<td>"
        if collection[i]
          result += render(:partial => partial, :object => collection[i])
        else
          result += "&nbsp"
        end       
        i = (orientation == :horizontal ? i + 1 : i + rows)
        result += "</td>"
      end
      
      result += "</tr>"
    end
    result += "</table>"
  end
end