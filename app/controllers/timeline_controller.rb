class TimelineController < ApplicationController
  def index
  end

  def search
    getter = GetDate.new
    @events = (1..3).map do |x|
      if params["event#{x}"] != ""
        event = Event.find_by(name: params["event#{x}"]) || getter.get(params["event#{x}"])
      end
    end
    @events.compact!
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js {}
    end
  end
end
