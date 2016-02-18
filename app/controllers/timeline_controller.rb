class TimelineController < ApplicationController
  def index
  end

  def search
    event_getter = GetDate.new
    @events = (1..3).map do |i|
      if params["event#{i}"] != ""
        event = Event.find_by(name: params["event#{i}"]) || event_getter.find_dates(params["event#{i}"])
      end
    end
    @events.compact!
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js {}
    end
  end
end
