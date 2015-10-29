config = {
  :api_key   => "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
}

dog = Datadog::Client.new(config)

puts "request:  #{JSON::stringify(event_data)}"
puts "response: #{dog.events("mruby.test", "test", :alert_type => "error")['body']}"

puts "request:  #{JSON::stringify(metrics_data)}"
puts "response: #{dog.series("mruby.test", 12345, :host => "foo.bar.com")['body']}"
