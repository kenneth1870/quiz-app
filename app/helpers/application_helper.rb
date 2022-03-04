module ApplicationHelper
  def get_pages_info(current_page, total_pages)
    string = "Showing "
    if current_page > 1
      string += (current_page*10-9).to_s
    else 
      string << "1"
    end
    string << " to " << (current_page*10).to_s << " of " << total_pages.to_s << " entries"
  end
  def get_row_number(page, i)
    i = i + 1
    if page >= 1
      ( page * 10 - 10 ) + i
    else
      page *   i
    end
  end
end
