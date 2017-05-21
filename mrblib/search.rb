class Datadog
  class Search < Client
    def search(get_data)
      query = %Q{&q=#{query}}
      begin
        res = get('query', query: query)
        res.body
      rescue => e
        puts e
      end
    end
  end
end
