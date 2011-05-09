module AdventHelper
  def todays_event?(event)
    (localtime(event.dtstart).beginning_of_day..localtime(event.dtend).end_of_day).include? Time.now
  end

  def localtime(datetime)
    datetime.to_time.localtime
  end

  def events_by_month(events)
    events.inject(ActiveSupport::OrderedHash.new) do |months, event|
      month = localtime(event.dtstart).beginning_of_month
      months[month] ||= []
      months[month] << event
      months
    end
  end
end
