class TimeFormatter
  AVAILABLE = %w[year month day hour minute second].freeze
  DATE = { 'year' => '%Y', 'month' => '%m', 'day' => '%D',
    'hour' => '%H', 'minute' => '%M', 'second' => '%S' }.freeze

  def initialize(input)
    @input, @unknown = input.partition { |v| AVAILABLE.member?(v) }
  end

  def perform
    valid? ? divided_time : @unknown
  end

  def divided_time
    format = @input.map { |m| DATE[m] }
    Time.now.strftime(format.join('-'))
  end

  def valid?
    @unknown.empty?
  end
end
