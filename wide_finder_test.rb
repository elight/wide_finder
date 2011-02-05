require 'minitest/autorun'
require 'benchmark'
require File.join(File.dirname(__FILE__), 'wide_finder')

class WideFinderTest < MiniTest::Unit::TestCase

  # Setup the TweetCatcher instance and some cheap mock values against which to test.
  def setup
    @filename = 'raw_data.log'
  end

  def run_wide_finder(mode, &url_finder)
    Benchmark.bmbm do |b|
      b.report(mode) do |b|
        10.times do
          sample = WideFinder.new(@filename, &url_finder)
          expected = [
            "11101: /search/image_set/20", 
            "8505: /search/image_set/40",
            "5263: /javascripts/jquery.js"
          ]
          assert_equal expected, sample.results(3)
        end
      end
    end
  end
  
  def test_that_it_finds_the_top_three_hits_using_split
    run_wide_finder "double split" do |line|
      url = line.split(" ")[6]
      url = url.split("?")[0] if url.include?("?")  
      url
    end
  end

  def test_that_it_finds_the_top_three_hits_using_regex
    run_wide_finder "regex" do |line|
      line =~ /"([A-Z]+)\s([^\s\?]+)/
      url = $2
    end
  end
end

