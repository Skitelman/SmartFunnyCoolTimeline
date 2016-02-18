class GetDate

  def initialize()
    options = { "format" => "plaintext" }
    @client = WolframAlpha::Client.new(ENV['WOLFRAM_KEY'], options)
  end

  def get(event)
    response = @client.query(event)
    basic_info = response.pods.find{ |pod| pod.title.downcase.include?("basic") || pod.title.downcase.include?("date") || pod.title.downcase.include?("information") }
    raw_dates = basic_info.subpods.map do |subpod|
      subpod.plaintext.split("\n").select{ |info| info.include?("date")}
    end.compact.flatten
    human = false
    date_strings = raw_dates.map do |date|
      if date.include?("birth")
        human = true
      end
      date.scan(/\|(.[^\(]*)/).flatten.first.split(" to ")
    end.flatten
    new_event = Event.create(name: event, human: human)
    begin
      new_event.start_time = DateTime.parse(date_strings.first)
    rescue ArgumentError
      new_event.start_time = DateTime.now
    end
    if date_strings.size > 1
      begin
        new_event.end_time = DateTime.parse(date_strings.last)
      rescue ArgumentError
        new_event.start_time = DateTime.now
      end
    end
    new_event.save
    new_event
  end

end
