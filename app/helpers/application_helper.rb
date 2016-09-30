module ApplicationHelper
  def pagination
    {class: "pagination center-align", previous_label: "<i class='material-icons'>chevron_left</i>".html_safe,
    next_label: "<i class='material-icons'>chevron_right</i>".html_safe}
  end
end
