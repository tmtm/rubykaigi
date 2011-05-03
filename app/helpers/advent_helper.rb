module AdventHelper
  def todays_event?(event)
    (localtime(event.dtstart).beginning_of_day..localtime(event.dtend).end_of_day).include? Time.now
  end

  def localtime(datetime)
    datetime.to_time.localtime
  end

end
