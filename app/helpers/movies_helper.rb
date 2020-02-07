module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  # Creates a list of all the possible ratings
  def self.all_ratings
    ['G','PG','PG-13','R']
  end
end
