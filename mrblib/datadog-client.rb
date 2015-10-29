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

    def events(title, text, args={})
      post_data = {
        :title => title,
        :text => text,
        :priority => args[:priority],
        :tags => [args[:tags]],
        :alert_type => args[:alert_type],
      }

      post("events", post_data)
    end

    def series(metric, points, args={})
      current_time = Time.now.to_i
      post_data = {
        :series => [{
          :metric => metric,
          :points => [[current_time, points.to_f]],
          :type => args[:type],
          :host => args[:host],
          :tags => args[:tags],
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
