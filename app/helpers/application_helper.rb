module ApplicationHelper
  def pagination
    { previous_label: "<i class='fa fa-angle-left' aria-hidden='true'></i>".html_safe,
    next_label: "<i class='fa fa-angle-right' aria-hidden='true'></i>".html_safe }
  end
end
