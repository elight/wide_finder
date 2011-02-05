class WideFinder
  def initialize(filename)
    url_histogram = nil
    File.open(filename, "r") do |handle|
      while line = handle.gets
        line =~ /"([A-Z]+)\s([^\s\?]+)/
        url = $2
        hash[url] += 1
        hash
      end
    end
    unformatted_results = Array(url_histogram).sort! { |a, b| a[1] <=> b[1] }.reverse
    @results = unformatted_results.inject([]) do |results, result| 
      results << "#{result[1]}: #{result[0]}"
    end
  end

  def results(how_many)
    @results[0, how_many]
  end
end
