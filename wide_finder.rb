class WideFinder
  def initialize(filename)
    url_histogram = nil
    handle = File.open(filename, "r")
    lines = handle.readlines
    handle.close
    url_histogram = lines.inject(Hash.new(0)) do |hash, line|
      line =~ /"([A-Z]+)\s([^\s\?]+)/
      url = $2
      hash[url] += 1
      hash
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
