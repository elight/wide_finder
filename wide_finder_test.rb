require 'minitest/autorun'
require 'benchmark'
require File.join(File.dirname(__FILE__), 'wide_finder')

class WideFinderTest < MiniTest::Unit::TestCase

  # Setup the TweetCatcher instance and some cheap mock values against which to test.
  def setup
    @filename = 'raw_data.log'
  end
  
  def test_that_it_finds_the_top_three_hits
    measure = Benchmark.measure do
      sample = WideFinder.new(@filename)
      expected = [
        "11101: /search/image_set/20", 
        "8505: /search/image_set/40",
        "5263: /javascripts/jquery.js"
      ]
      assert_equal expected, sample.results(3)
    end
    puts measure
  end
end

