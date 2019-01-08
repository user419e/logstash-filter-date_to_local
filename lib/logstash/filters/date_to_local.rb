# encoding: utf-8
require "logstash/filters/base"
#require "logstash/namespace"
require "date"

class LogStash::Filters::DateToLocal < LogStash::Filters::Base

  config_name "date_to_local"


  config :source, :validate => :string, :default => LogStash::Event::TIMESTAMP
  config :target, :validate => :string, :default => "ltimestamp"


  public
  def register

  end # def register

  public
  def filter(event)

    if @source
      begin
        local_time = DateTime.parse(event.get(@source).to_s).new_offset(DateTime.now.offset)
        local_time = local_time.strftime("%d %b %H:%M:%S.%L %z")
        event.set(@target, local_time)
      rescue Exception => e
        event.tag("_date_to_local_filter_exception")
      end
    end


    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Example




