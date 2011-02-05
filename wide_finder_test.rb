require 'minitest/autorun'
require 'benchmark'
require File.join(File.dirname(__FILE__), 'wide_finder')

class WideFinderTest < MiniTest::Unit::TestCase

  # Setup the TweetCatcher instance and some cheap mock values against which to test.
  def setup
    @filename = 'raw_data.log'
    @num_times = 10
  end

  def run_wide_finder(mode, &url_finder)
    Benchmark.bm do |b|
      b.report(mode) do |b|
        @num_times.times do 
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
      line = line.split("?")[0] if line.include?("?")  
      line.split(" ")[6]
    end
  end

  def test_that_it_finds_the_top_three_hits_using_regex
    run_wide_finder "regex" do |line|
      $2 if line =~ /"([A-Z]+)\s([^\s\?]+)/
    end
  end
end

