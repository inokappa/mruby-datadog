class Datadog
  class Client
    def initialize(config)
      @url       = 'https://app.datadoghq.com/api/v1/'
      @api_key   = '?api_key=' + config[:api_key]
      @request   = {
        'Content-Type'   => "Content-type: application/json",
        'User-Agent'     => "mruby-datadog-client",
      }
    end

    def events(post_data)
      post("events", post_data)
    end

    def series(metrics_data)
      # metrics_data = {
      #   :metrics => "mruby.test",
      #   :points => "12345",
      #   :host => "foo.bar.com",
      # }
      current_time = Time.now.to_i
      post_data = {
        :series => [{
          :metric => metrics_data[:metrics],
          :points => [[current_time, metrics_data[:points].to_i]],
          :host => metrics_data[:host]
        }]
      }
      post("series", post_data)
    end
    
    def post(api_path, data)
      http = HttpRequest.new()
      url = @url + api_path + @api_key 
      http.post(url, JSON::stringify(data), @request)
    end
  end
end
