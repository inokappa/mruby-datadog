# Datadog API client for mruby

## Supported API

- [Events](http://docs.datadoghq.com/ja/api/?lang=console#events)
- [Metrics](http://docs.datadoghq.com/ja/api/?lang=console#metrics)
- [Monitors](http://docs.datadoghq.com/ja/api/?lang=console#monitors)
- [Search](http://docs.datadoghq.com/ja/api/?lang=console#search)

## Required

- https://github.com/matsumoto-r/mruby-httprequest.git
- https://github.com/mattn/mruby-json.git
- https://github.com/luisbebop/mruby-polarssl.git

## install by mrbgems

- git clone mruby-datadog

```sh
cd ${mruby_root}/mrbgems/
git clone https://github.com/inokappa/mruby-datadog.git
```

- modify build_config.rb

```ruby
(snip)

  conf.gem :git => 'https://github.com/matsumoto-r/mruby-httprequest.git'
  conf.gem :git => 'https://github.com/mattn/mruby-json.git'
  conf.gem :git => 'https://github.com/luisbebop/mruby-polarssl.git'
  conf.gem 'mrbgems/mruby-datadog'

(snip)
```

- build mruby

```sh
cd ${mruby_root}/
make
```

## example

```ruby
config = {
  :api_key => "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  :app_key => "yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy"
}

#
# Monitors
#
dog = Datadog::Monitors.new(config)
res = dog.get_all_monitors
p res.length
res = dog.get_all_monitors(tags: "host:vagrant-ubuntu-trusty-64")
p res.length
res.each do |monitor|
  p monitor
end
puts dog.get_monitor(1234567)

options = {
  'notify_no_data' => true,
  'no_data_timeframe' => 20
}
tags = ['app:webserver', 'frontend']
puts dog.monitor("metric alert", \
            "avg(last_1h):sum:system.net.bytes_rcvd{host:host0} > 100", \
            :name => "Bytes received on host1", \
            :message => "We may need to add web hosts if this is consistently high.", \
            :tags => tags, \
            :options => options)

puts dog.monitor("metric alert", \
          "avg(last_1h):sum:system.net.bytes_rcvd{host:host1} > 100")

puts dog.update_monitor(1234567, "metric alert", \
            "avg(last_1h):sum:system.net.bytes_rcvd{host:host1} > 100")

puts dog.delete_monitor(1234567)
puts dog.get_monitor(1234567)

puts dog.mute_monitor(1234567)
puts dog.unmute_monitor(1234567)

puts dog.mute_monitors
puts dog.unmute_monitors

#
# Metrics
#
dog = Datadog::Metrics.new(config)
puts "response: #{dog.emit_points("mruby.test", 50, :host => "foo.bar.com")}"
points = [[Time.now.to_i, 1], [Time.now.to_i + 10, 10], [Time.now.to_i + 20, 20]]
puts "response: #{dog.emit_points("mruby.test2", points, :host => "foo.bar.com")}"

from = Time.now.to_i - 3600
to = Time.now.to_i
query = 'system.cpu.idle{*}by{host}'
puts dog.get_points(query, from, to)

#
# Search
#
dog = Datadog::Search.new(config)
dog.search("host:vagrant-ubuntu-trusty-64")
```
