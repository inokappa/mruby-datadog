## Datadog API client for mruby

### required

- https://github.com/matsumoto-r/mruby-httprequest.git
- https://github.com/mattn/mruby-json.git
- https://github.com/luisbebop/mruby-polarssl.git

### referenced

- https://github.com/matsumoto-r/mruby-zabbix 

### install by mrbgems

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

### example

- datadog-api-client.rb

```ruby
config = {
  :api_key   => "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
}

dog = Datadog::Client.new(config)

# Events
puts "response: #{dog.events("mruby.test", "test", :alert_type => "error")['body']}"

# Metrics
puts "response: #{dog.series("mruby.test", 12345, :host => "foo.bar.com")['body']}"

# Searh
puts "response: #{dog.search("foo")['body']}"
```

- execute

```sh
mruby datadog-api-client.rb
```

- output

```javascript
response: {"status":"ok","event":{"id":251030430326433344,"title":"mruby","text":"test","date_happened":1446077768,"handle":null,"priority":null,"related_event_id":null,"tags":null,"url":"https://propjoe.agent.datadoghq.com/event/event?id=251030430326433344"}}
response: {"status": "ok"}
response: {"results": {"metrics": [], "hosts": ["foo.bar.com"]}}
```
