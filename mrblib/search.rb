class Datadog
  class Search < Client
    def search(get_data)
      get("search", get_data)
    end
  end
end
