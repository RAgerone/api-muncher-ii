class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search?"
  ID = ENV["EDAMAM_ID"]
  KEY = ENV["EDAMAM_KEY"]

  def self.list_recipes(search_terms)
    url = BASE_URL + "q=" + search_terms + "&app_id=#{ID}" + "&app_key=#{KEY}&from=0&to=99"

    data = HTTParty.get(url)
    check_status(data)
    data_parsed = data.parsed_response["hits"]
    recipe_list = []
    unless data_parsed.empty?
      data_parsed.each do |recipe_data|
        recipe_list << create_recipe(recipe_data['recipe'])
      end
    else
      return "Empty Array in data_parsed"
    end
    return recipe_list
  end #end list

  def self.find_recipe(search_url)
    url = BASE_URL + "r=" + "http://www.edamam.com/ontologies/edamam.owl%23" + search_url + "&app_id=#{ID}" + "&app_key=#{KEY}"
    data = HTTParty.get(url)

    check_status(data)

    data_parsed = data.parsed_response[0]
    if data_parsed.nil? || data_parsed.empty?
      return "Empty Array or nil in data_parsed"
    end
    recipe = create_recipe(data_parsed)
  end #end list

  class ApiError < StandardError
  end

  def self.check_status(response)
    unless response.message == "OK"
      raise ApiError.new("API call to slack failed: #{response["error"]}")
    end
  end

  private
  #
  def self.create_recipe(api_params)
    Recipe.new(
      api_params['label'],
      api_params['uri'],
      api_params['image'],
      api_params['ingredientLines'],
      api_params['healthLabels'],
      api_params['totalNutrients'],
      api_params['url']
    )
  end

end# end SlackApiWrapper
