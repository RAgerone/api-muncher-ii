class Recipe
  attr_reader :name, :uri, :image, :ingredients, :health_labels, :nutrient_info, :url

  def initialize(name, uri, image = "", ingredients = "", health_labels = "", nutrient_info = "", url= "")
    raise ArgumentError if name == nil || name == "" || uri == nil || uri == ""
    # binding.pry
    @name = name
    @uri = uri
    @image = image
    @ingredients = ingredients
    @health_labels = health_labels
    @nutrient_info = nutrient_info
    @url = url

    # @is_general = options[:is_archived]
    # @members = options[:members]
  end
end
