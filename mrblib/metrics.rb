class Datadog
  class Metrics < Client
    def emit_points(metric, points, args = {})
      current_time = Time.now.to_i
      data = {}
      data[:metric] = metric
      if points.kind_of?(Array)
        data[:points] = points
      else
        data[:points] = [[current_time, points.to_f]]
      end
      args.each { |key, value| data[key] = value } unless args.empty?

      post_data = {}
      post_data[:series] = [data]
      begin
        res = post('series', data: post_data)
        res.body
      rescue => e
        puts e
      end
    end

    def get_points(query, from, to)
      query = %Q{&query=#{query}&from=#{from}&to=#{to}}
      begin
        res = get('query', query: query)
        res.body
      rescue => e
        puts e
      end
    end
  end
end
