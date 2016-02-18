class Event < ActiveRecord::Base
  def start_string
    self.start_time.strftime("%Y-%m-%d")
  end
  def end_string
    if self.end_time
      self.end_time.strftime("%Y-%m-%d")
    elsif self.human
      DateTime.now.strftime("%Y-%m-%d")
    else
      false
    end
  end
end
