module UsersHelper
  def sorting_link(column, table)
    sorting_order = (params[:column] == column) ? toggle_order(params["#{table}_sorting"]) : "ASC"
    link_to(icon_for_sorting(sorting_order), user_path(params[:id], column: column, "#{table}_sorting" => sorting_order), remote: true)
  end

  def toggle_order(order)
    order == "ASC" ? "DESC" : "ASC"
  end

  def icon_for_sorting(order)
    "<i class='fa fa-sort-amount-#{order.downcase}' aria-hidden='true'></i>".html_safe
  end

  def serial_no(page_no, index)
    page_no ||= 1
    (page_no.to_i-1)*3 + index + 1
  end
end
