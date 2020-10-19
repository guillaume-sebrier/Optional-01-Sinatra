class Recipe
  attr_reader :name, :description, :link, :duration, :rating
  attr_accessor :read

  def initialize(config = {})
    @name = config[:name] || ""
    @description = config[:description] || ""
    @rating = config[:rating] || ""
    @read = (true if config[:read] == ("true" || true)) || false
    @duration = config[:duration] || ""
    @link = config[:link] || ""
  end
end
