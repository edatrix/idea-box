
class Idea
  include Comparable

  attr_reader :title, :description, :rank, :id

  def initialize(attributes = {})
    @title = attributes["title"]
    @description = attributes["description"]
    @id = attributes ["id"]
    @rank = attributes["rank"] || 0
  end

  def save
    IdeaStore.create(to_h)
  end

  def <=>(other)
    other.rank <=> rank
  end

  def like!
    @rank += 1
  end

  def to_h
    {
     "title" => title,
     "description" => description,
     "rank" => rank
    }
  end

  def database
    @database ||= YAML::Store.new "ideabox"
  end

end
