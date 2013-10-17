gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'


class IdeaTest < Minitest::Test

  def test_basic_idea
    idea = Idea.new("dinner", "chicken BBQ pizza")

    assert_equal "dinner", idea.title
    assert_equal "chicken BBQ pizza", idea.description
  end

end
