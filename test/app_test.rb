gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/app'
# require 'rack/test'


class AppTest < Minitest::Test
  # include Rack::Test::Methods

  def app
    IdeaBoxApp
  end

  def test_hello
    get '/'
    assert_equal "testing testing!", last_response.body
  end

end
