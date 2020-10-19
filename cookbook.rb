require "csv"
require_relative "recipe"

class Cookbook
  def initialize(csv_file_path)
    @filepath = csv_file_path
    @recipes = []
    unless @filepath == ""
      CSV.foreach(@filepath) do |row|
        @recipes << Recipe.new(
          { name: row[0], description: row[1],
            rating: row[2], read: row[3], duration: row[4], link: row[5] }
        )
      end
    end
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    CSV.open(@filepath, 'wb') do |csv|
      @recipes.each do |item|
        csv << [item.name, item.description, item.rating, item.read, item.duration, item.link]
      end
    end
  end

  def mark_as_read(recipe_index)
    find(recipe_index).read = true
    CSV.open(@filepath, 'wb') do |csv|
      @recipes.each do |item|
        csv << [item.name, item.description, item.rating, item.read, item.duration, item.link]
      end
    end
  end

  def find(index)
    @recipes[index]
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    CSV.open(@filepath, 'wb') do |csv|
      @recipes.each do |item|
        csv << [item.name, item.description, item.rating, item.read, item.duration, item.link]
      end
    end
  end
end
