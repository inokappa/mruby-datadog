class Datadog
  class Monitors < Client
    def monitor(type, query, *args)
      data = monitor_data(type, query, *args)
      begin
        res = post('monitor', data: data)
        response(res.body)
      rescue => e
        puts e
      end
    end

    def get_monitor(monitor_id)
      uri_path = %Q{monitor/#{monitor_id}}
      begin
        res = get(uri_path)
        response(res.body)
      rescue => e
        puts e
      end
    end

    def get_all_monitors
      begin
        res = get('monitor')
        response(res.body)
      rescue => e
        puts e
      end
    end

    def update_monitor(monitor_id, type, query, *args)
      data = monitor_data(type, query, *args)
      uri_path = %Q{monitor/#{monitor_id}}
      begin
        res = post(uri_path, data: data)
        response(res.body)
      rescue => e
        puts e
      end
    end

    def delete_monitor(monitor_id)
      uri_path = %Q{monitor/#{monitor_id}}
      begin
        res = delete(uri_path)
        response(res.body)
      rescue => e
        puts e
      end
    end

    def mute_monitor(monitor_id, options = {})
      uri_path = %Q{monitor/#{monitor_id}/mute}
      begin
        res = post(uri_path)
        response(res.body)
      rescue => e
        puts e
      end
    end

    def unmute_monitor(monitor_id, options = {})
      uri_path = %Q{monitor/#{monitor_id}/unmute}
      begin
        res = post(uri_path)
        response(res.body)
      rescue => e
        puts e
      end
    end

    def mute_monitors
      uri_path = %Q{monitor/mute_all}
      begin
        res = post(uri_path)
        response(res.body)
      rescue => e
        puts e
      end
    end

    def unmute_monitors
      uri_path = %Q{monitor/unmute_all}
      begin
        res = post(uri_path)
        res.body
      rescue => e
        puts e
      end
    end

    private

    def response(body)
      JSON.parse(body)
    end

    def monitor_data(type, query, *args)
      #
      # type
      # query
      # :name, :message, :tags, :options
      #
      data = {}
      data[:type] = type
      data[:query] = query
      args.last.each { |key, value| data[key] = value } unless args.empty?
      data
    end
  end
end
