module UsersHelper
  def sorting_link(column)
    sorting_order = (params[:column] == column) ? toggle_order(params[:sorting_order]) : "ASC"
    link_to(sorting_order, user_path(params[:id], column: column, sorting_order: sorting_order), remote: true)
  end

  def toggle_order(order)
    order == "ASC" ? "DESC" : "ASC"
  end
end
