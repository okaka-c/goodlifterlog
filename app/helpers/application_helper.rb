module ApplicationHelper
  def flash_background_color(type)
    case type.to_sym
    when :success then "bg-success text-success-content"
    when :danger  then "bg-error text-error-content"
    else "bg-gray-500 text-black"
    end
  end

  def default_meta_tags
    {
      og: {
        title: "PowerLifter's Log",
        description: 'パワーリフティング/シングルベンチプレス大会の大会結果を記録・管理！',
        image: image_url('firstview.png'),
      },
      twitter: {
        card: 'summary_large_image',
        domain: 'powerlifterslog.com'
      }
    }
  end
end
