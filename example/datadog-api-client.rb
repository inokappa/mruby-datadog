config = {
  :api_key   => "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
}

dog = Datadog::Client.new(config)

event_data = {
  :title => "mruby",
  :text => "test",
  :alert_type => "warning",
}

puts "request:  #{JSON::stringify(event_data)}"
puts "response: #{dog.events(event_data)['body']}"

metrics_data = {
  :metrics => "mruby.test",
  :points => "12345",
  :host => "foo.bar.com",
}

puts "request:  #{JSON::stringify(metrics_data)}"
puts "response: #{dog.series(metrics_data)['body']}"
