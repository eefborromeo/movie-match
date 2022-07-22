module TMDB
    module Api
        class Client
            BASE_URL = "https://api.themoviedb.org/3/".freeze
            API_KEY = Rails.application.credentials.dig(:tmdb, :api_key)
            BEARER_TOKEN = Rails.application.credentials.dig(:tmdb, :bearer_token)

            def get_token
                send_request(:get, "authentication/token/new?api_key=#{API_KEY}")
            end

            def get_session_id(token)
                send_request(:post, "authentication/session/new?api_key=#{API_KEY}&request_token=#{token}")
            end

            def search_movie_id(keyword)
                send_request(:get, "search/movie?api_key=#{API_KEY}&language=en-US&query=#{keyword}&page=1&include_adult=false")
            end

            def get_similar_movies(id)
                send_request(:get, "movie/#{id}/similar?api_key=#{API_KEY}&language=en-US&page=#{rand(1..10)}")
            end

            def add_to_watchlist(session_id, id)
                account_id = get_account_id(session_id)
                send_request(:post, "account/#{account_id}/watchlist?api_key=#{API_KEY}&session_id=#{session_id}", "{\"media_type\": \"movie\", \"media_id\": #{id},\"watchlist\": true}")
            end 

            def get_watchlist(session_id)
                account_id = get_account_id(session_id)
                send_request(:get, "account/#{account_id}/watchlist/movies?api_key=#{API_KEY}&language=en-US&session_id=#{session_id}&sort_by=created_at.asc&page=1")
            end
                
            private
                
            def get_account_id(session_id)
                send_request(:get, "account?api_key=#{API_KEY}")["id"]
            end

            def send_request(method, resource, body = nil)
                connection = Faraday.new(
                    url: BASE_URL, 
                    params: {},
                    headers: {
                        "Authorization" => "Bearer #{BEARER_TOKEN}",
                        "Content-Type" => "application/json;charset=utf-8"
                })
                response = connection.public_send(method, resource, body)
                JSON.parse(response.body)
            end
        end
    end
end