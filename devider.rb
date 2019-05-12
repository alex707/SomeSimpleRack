# contain format logic
class Devider
  AVAILABLE = %w[year month day hour minute second].freeze

  def initialize(input)
    @input = input
  end

  def handle_time
    unknown = @input.reject { |el| AVAILABLE.member?(el) }
    if unknown.any?
      [400, unknown_param(unknown)]
    else
      [200, divided_time + "\n"]
    end
  end

  def unknown_param(params)
    "Unknown time format [#{params.join(' ')}]\n"
  end

  def divided_time
    (AVAILABLE & @input).map do |m|
      case m
      when 'year', 'day', 'hour', 'minute', 'second'
        Time.now.strftime("%#{m[0].upcase}")
      when 'month'
        Time.now.strftime('%m')
      end
    end.join('-')
  end
end
