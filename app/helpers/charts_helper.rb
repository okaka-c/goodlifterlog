module ChartsHelper
  def format_dates_and_weights(data)
    data.map do |date, weight|
      [date.strftime("%Y-%-m-%-d"), weight]
    end
  end
end
