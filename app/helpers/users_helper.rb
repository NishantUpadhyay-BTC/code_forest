module UsersHelper
  def sorting_link(column, table)
    sorting_order = (params[:column] == column) ? toggle_order(params["#{table}_sorting"]) : "ASC"
    link_to(sorting_order, user_path(params[:id], column: column, "#{table}_sorting" => sorting_order), remote: true)
  end

  def toggle_order(order)
    order == "ASC" ? "DESC" : "ASC"
  end
end
