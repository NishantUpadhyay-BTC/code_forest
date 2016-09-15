module Support
  module Common
    def self.get_response(path)
      begin
        uri = URI(path)
        http_response = Net::HTTP.get_response(uri)
        JSON(http_response.body).symbolize_keys
      rescue e
        #write code for handling exception
      end
    end
  end
end
