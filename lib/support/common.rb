module Support
  module Common
    def self.get_response(path)
      begin
        uri = URI(path)
        http_response = Net::HTTP.get_response(uri)
        response = JSON(http_response.body).symbolize_keys
        if response[:message].present?
          raise StandardError.new(response[:message])
        end
        response
      rescue => e
        raise StandardError.new(e)
      end
    end
  end
end
