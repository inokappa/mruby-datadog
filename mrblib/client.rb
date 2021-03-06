class Datadog
  class Client
    API_VERSION = 'v1'
    def initialize(config)
      @url       = 'https://app.datadoghq.com/api/' + API_VERSION + '/'
      @api_key   = config[:api_key]
      @app_key   = config[:app_key]
      @credential_path = '?api_key=' + @api_key + '&application_key=' + @app_key
      @request   = {
        'Content-Type'   => "Content-type: application/json",
        'User-Agent'     => "mruby-datadog-client",
      }
    end

    def get(uri_path, args = {})
      url = @url + uri_path + @credential_path
      return http.get(url, @request) if args[:query] == nil
      http.get(url + '&' + args[:query], @request)
    end

    def post(uri_path, args = {})
      url = @url + uri_path + @credential_path
      if args[:data]
        http.post(url, JSON::stringify(args[:data]), @request)
      else
        http.post(url, @request)
      end
    end

    def put(uri_path, args = {})
      url = @url + uri_path + @credential_path
      if args[:data]
        http.put(url, JSON::stringify(args[:data]), @request)
      else
        http.put(url, @request)
      end
    end

    def delete(uri_path)
      url = @url + uri_path + @credential_path
      http.delete(url, @request)
    end

    def http
      HttpRequest.new()
    end
  end
end
