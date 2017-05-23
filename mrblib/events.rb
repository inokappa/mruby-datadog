class Datadog
  class Events < Client
    def emit_event(msg_text, args = {})
      post_data = {
        :text => msg_text,
        :title => args[:msg_title],
        :priority => args[:priority],
        :tags => [args[:tags]],
        :alert_type => args[:alert_type],
      }

      res = post('events', data: post_data)
      res.body
    end

    def get_event(event_id)
      uri_path = %Q{events/#{event_id}}
      begin
        res = get(uri_path)
        res.body
      rescue => e
        puts e
      end
    end

    def delete_event(event_id)
      uri_path = %Q{events/#{event_id}}
      begin
        res = delete(uri_path)
        res.body
      rescue => e
        puts e
      end
    end
  end
end
