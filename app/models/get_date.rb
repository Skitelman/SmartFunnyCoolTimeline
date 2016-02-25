class GetDate

  def initialize()
    options = { "format" => "plaintext" }
    @client = WolframAlpha::Client.new(ENV['WOLFRAM_KEY'], options)
  end

  def find_dates(event)
    response = @client.query(event)
    basic_info_pod = get_basic_info_pod(response)
    raw_dates = get_date_response_strings(basic_info_pod)
    human = false
    create_event_from_raw_dates(event, raw_dates, human)
  end

  def get_basic_info_pod(response)
    response.pods.find{ |pod| pod.title.downcase.include?("basic") || pod.title.downcase.include?("date") || pod.title.downcase.include?("information") }
  end

  def get_date_response_strings(basic_info_pod)
    basic_info_pod.subpods.map do |subpod|
      subpod.plaintext.split("\n").select{ |info| info.include?("date")}
    end.compact.flatten
  end

  def create_event_from_raw_dates(event, raw_dates, human)
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
