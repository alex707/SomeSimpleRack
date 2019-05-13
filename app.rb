# main class rack app.
class App
  def call(env)
    req = Rack::Request.new(env)
    case req.path_info
    when /time/
      time_handler(req.params['format'].split(','))
    else
      make_response(404, 'Page not found')
    end
  end

  private

  def time_handler(params)
    query = TimeFormatter.new(params)
    if query.valid?
      make_response(200, query.perform)
    else
      make_response(400, "Unknown time format [#{query.perform.join(' ')}]")
    end
  end

  def plain_headers
    { 'Content-Type' => 'text/plain' }
  end

  # rubocop:disable Style/OptionalArguments
  def make_response(status_code, headers = plain_headers, body)
    [status_code, headers, Array(body + "\n")]
  end
  # rubocop:enable Style/OptionalArguments

  def status(obj)
    obj.valid? ? 200 : 400
  end
end
