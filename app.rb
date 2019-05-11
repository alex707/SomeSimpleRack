# This shiny app class. simple rack app
class App
  AVAILABLE = %w[year month day hour minute second].freeze

  def call(env) # rubocop:disable Metrics/MethodLength
    req = Rack::Request.new(env)
    case req.path_info
    when /time/
      input = req.params['format'].split(',')
      unknown = input.reject { |el| AVAILABLE.member?(el) }
      if unknown.any?
        [400, headers, ["Unknown time format [#{unknown.join(' ')}]\n"]]
      else
        [200, headers, [divided_time(input) + "\n"]]
      end
    else
      [404, headers, ["Page not found\n"]]
    end
  end

  private

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def divided_time(input)
    (AVAILABLE & input).map do |m|
      case m
      when 'year', 'month', 'day', 'hour'
        Time.now.send(m).to_s.rjust(2, '0')
      when 'minute'
        format('%02d', Time.now.send('min'))
      when 'second'
        format('%02d', Time.now.send('sec'))
      end
    end.join('-')
  end
end
