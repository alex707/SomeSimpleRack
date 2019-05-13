# contain format logic
class TimeFormatter
  AVAILABLE = %w[year month day hour minute second].freeze

  def initialize(input)
    @input, @unknown = input.partition { |v| AVAILABLE.member?(v) }
  end

  def perform
    valid? ? divided_time : @unknown
  end

  def divided_time
    formath = (AVAILABLE & @input).map do |m|
      { 'year' => '%Y', 'month' => '%m', 'day' => '%D',
        'hour' => '%H', 'minute' => '%M', 'second' => '%S' }[m]
    end
    Time.now.strftime(formath.join('-'))
  end

  def valid?
    @unknown.empty?
  end
end
