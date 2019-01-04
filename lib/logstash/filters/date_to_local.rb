# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"
require "date"

class LogStash::Filters::DateToLocal < LogStash::Filters::Base

  config_name "date_to_local"


  config :source, :validate => :string, :default => LogStash::Event::TIMESTAMP
  config :target, :validate => :string, :default => "localdate"


  public
  def register

  end # def register

  public
  def filter(event)

    if @source
      dt = DateTime.new(@source)
      local_time = dt.new_offset(DateTime.now.offset)
      event.set(@target,local_time.strftime('%d %b %H:%M:%S.%L %z'))
    end


    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Example




