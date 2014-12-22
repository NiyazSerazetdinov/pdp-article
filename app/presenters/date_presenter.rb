class DatePresenter < BasePresenter

  def initialize(date)
    @date = date
  end

  def human_date
    case @date.to_date
    when Date.today
      "Today #{time}"
    when Date.tomorrow
      "Yesterday #{time}"
    else
      "on #{@date.strftime("%b %d, %Y")} #{time}"
    end
  end

  def time
    @date.strftime("at %I:%M%p")
  end
end
