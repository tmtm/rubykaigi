module AdventHelper
  def todays_event?(event)
    (event.dtstart.beginning_of_day..event.dtend.end_of_day).include? Time.now
  end

  def events_by_month(events)
    events.inject(ActiveSupport::OrderedHash.new) do |months, event|
      month = event.dtstart.beginning_of_month
      months[month] ||= []
      months[month] << event
      months
    end
  end
end
