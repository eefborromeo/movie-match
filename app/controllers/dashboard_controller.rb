class DashboardController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:approve]

    def index
        client = TMDB::Api::Client.new
        session_id = current_user.session_id
        @token = client.get_token["request_token"]
        @watchlist = client.get_watchlist(session_id)["results"]
        
        if params[:request_token]
            session = client.get_session_id(params[:request_token])
            current_user.session_id = session["session_id"]
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

    def approve
        client = TMDB::Api::Client.new
        session_id = current_user.session_id
        movie_id = params[:id]

        client.add_to_watchlist(session_id, movie_id)
    end
end
