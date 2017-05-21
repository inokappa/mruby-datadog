class Datadog
  class Series < Client
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
  end
end
