class Datadog
  class Monitors < Client
    def monitor(type, query, args = {})
      data = monitor_data(type, query, args)
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

    def get_all_monitors(args = {})
      params = args.clone
      if params[:group_states].respond_to?(:join)
        params[:group_states] = params[:group_states].join(',')
      end
      params[:tags] = params[:tags].join(',') if params[:tags].respond_to?(:join)
      params[:name] = params[:name] if params[:name]

      query = []
      params.each do |key, value|
        query << %Q{#{key.to_s}=#{value}}
      end

      begin
        res = get('monitor', query: query.join('&'))
        response(res.body)
      rescue => e
        puts e
      end
    end

    def update_monitor(monitor_id, type, query, args = {})
      data = monitor_data(type, query, args)
      uri_path = %Q{monitor/#{monitor_id}}
      begin
        res = put(uri_path, data: data)
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

    def mute_monitor(monitor_id, args = {})
      uri_path = %Q{monitor/#{monitor_id}/mute}
      begin
        res = post(uri_path)
        response(res.body)
      rescue => e
        puts e
      end
    end

    def unmute_monitor(monitor_id, args = {})
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

    def monitor_data(type, query, args = {})
      #
      # type
      # query
      # :name, :message, :tags, :options
      #
      data = {}
      data[:type] = type
      data[:query] = query
      args.each { |key, value| data[key] = value } unless args.empty?
      data
    end
  end
end
