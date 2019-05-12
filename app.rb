# main class rack app.
class App
  def call(env)
    req = Rack::Request.new(env)
    case req.path_info
    when /time/
      input = req.params['format'].split(',')
      status_code, body = Devider.new(input).handle_time
      make_response(status_code, plain_headers, body)
    else
      make_response(404, plain_headers, "Page not found\n")
    end
  end

  private

  def plain_headers
    { 'Content-Type' => 'text/plain' }
  end

  def make_response(status_code, headers, body)
    [status_code, headers, Array(body)]
  end
end
