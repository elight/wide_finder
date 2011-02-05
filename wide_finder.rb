class WideFinder
  def initialize(filename)
    url_histogram = Hash.new(0)
    File.open(filename, "r") do |handle|
      while line = handle.gets
        line =~ /"([A-Z]+)\s([^\s\?]+)/
        url_histogram[$2] += 1
      end
    end
    @results = url_histogram.sort { |a, b| a[1] <=> b[1] }.reverse
  end

  def results(how_many)
    @results[0,how_many].inject([]) do |results, result| 
      results << "#{result[1]}: #{result[0]}"
    end
  end
end
