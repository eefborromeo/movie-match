class DashboardController < ApplicationController
    def index
        client = TMDB::Api::Client.new
        @token = client.get_token["request_token"]
        
        if current_user.session_id == nil && params[:request_token]
            session = client.session_id(params[:request_token])
            current_user.session_id = session
            current_user.save
        end
    end

    def search
        client = TMDB::Api::Client.new

        @search = params[:movie]
        result_with_spaces = @search.split(" ").join("%20")
        id = client.search_movie_id(result_with_spaces)["results"][0]["id"]
        @similar_movies = client.get_similar_movies(id)["results"]
    end
end
