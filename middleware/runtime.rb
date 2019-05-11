# its middleware class for showing time of executing app
class Runtime
  def initialize(app)
    @app = app
  end

  def call(env)
    start = Time.now
    status, headers, body = @app.call(env)
    # rubocop:disable Style/FormatStringToken, Style/FormatString
    headers['X-Runtime'] = '%ds' % (Time.now - start)
    # rubocop:enable Style/FormatStringToken, Style/FormatString

    [status, headers, body]
  end
end
