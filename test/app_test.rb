ENV["RACK_ENV"] = "test"

gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/app'
require 'rack/test'


class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    IdeaBoxApp
  end

  def teardown
    IdeaStore.destroy
  end

  def test_hello
    get '/'
    assert_equal 200, last_response.status
  end

  def test_an_idea_can_be_created_via_sms
    assert_equal 0, IdeaStore.all.count

    url = "/sms"
    params = {"Body" => "breathe, fresh air in the mountains"}

    get url, params

    assert_equal 1, IdeaStore.all.count
    idea = IdeaStore.all.last

    assert_equal "breathe", idea.title
    assert_equal "fresh air in the mountains", idea.description

  end

end
