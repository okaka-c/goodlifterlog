module ApplicationHelper
  def flash_background_color(type)
    case type.to_sym
    when :success then "bg-success text-success-content"
    when :danger  then "bg-error text-error-content"
    else "bg-gray-500 text-black"
    end
  end
end
