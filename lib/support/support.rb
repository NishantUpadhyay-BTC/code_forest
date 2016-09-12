module Support
  module Common
    def get_response(path)
      uri = URI(path)
      http_response = Net::HTTP.get_response(uri)
      JSON(http_response.body).symbolize_keys
    end 
  end
end