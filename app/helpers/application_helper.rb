module ApplicationHelper
  def flash_background_color(type)
    case type.to_sym
    when :success then "bg-green-50 text-green-500"
    when :danger  then "bg-red-50 text-red-500"
    else "bg-gray-500 text-black"
    end
  end
end
