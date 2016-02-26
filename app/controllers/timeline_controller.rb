class TimelineController < ApplicationController
  def index
  end

  def search
    event_getter = GetDate.new
    @events = (1..3).map do |i|
      if params["event#{i}"] != ""
        if params["user#{i}"]["event"]
          event = Event.create(event_params(i))
        else
          event = Event.find_by(name: params["event#{i}"]) || event_getter.find_dates(params["event#{i}"])
        end
      end
    end
    @events.compact!
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js {}
    end
  end

  private
  def event_params(i)
    {name:params["event#{i}"],
    human: false,
    start_time: DateTime.parse(params["user#{i}"]["start_event"]),
    end_time: DateTime.parse(params["user#{i}"]["end_event"])}
  end
end
