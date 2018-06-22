# frozen_string_literal: true

module RmsWebService
  module Client
    class Navigation < Base
      def genre_get(genre_id)
        request = connection("navigation/genre/get").get { |req| req.params["genreId"] = genre_id }
        ::RWS::Response::Navigation::Genre::Get.new(request.body)
      end
    end
  end
end
