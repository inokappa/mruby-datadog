class Datadog
  class Downtimes < Client
    def schedule_downtime(scope, args = {})
      data = {
        scope: scope,
        start: args[:start],
        end: args[:end],
        recurrence: {
          type: args[:recurrence][:type],
          period: args[:recurrence][:period].to_i,
          week_days: args[:recurrence][:week_days],
          until_date: args[:recurrence][:until_date]
        }
      }
      begin
        res = post('downtime', data: data)
        response(res)
      rescue => e
        puts e
      end
    end

    def get_downtime(downtime_id)
      uri_path = %Q{downtime/#{downtime_id}}
      begin
        res = get(uri_path)
        response(res)
      rescue => e
        puts e
      end
    end

    def get_all_downtimes(args = {})
      params = args.clone
      query = []
      params.each do |key, value|
        query << %Q{#{key.to_s}=#{value}}
      end

      begin
        res = get('downtime', query: query.join('&'))
        response(res)
      rescue => e
        puts e
      end
    end

    def update_downtime(downtime_id, args = {})
      uri_path = %Q{downtime/#{downtime_id}}
      data = {
        scope: args[:scope],
        start: args[:start],
        end: args[:end],
        message: args[:message],
        recurrence: {
          type: args[:recurrence][:type],
          period: args[:recurrence][:period].to_i,
          week_days: args[:recurrence][:week_days],
          until_date: args[:recurrence][:until_date]
        }
      }
      begin
        res = put(uri_path, data: data)
        response(res)
      rescue => e
        puts e
      end
    end

    def cancel_downtime(downtime_id)
      uri_path = %Q{downtime/#{downtime_id}}
      begin
        res = delete(uri_path)
        res
      rescue => e
        puts e
      end
    end

    private

    def response(res)
      response_data = []
      response_data.push(res.code)
      response_data.push(JSON.parse(res.body))
      response_data
    end
  end
end
