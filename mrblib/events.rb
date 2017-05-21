class Datadog
  class Events < Client
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
  end
end
