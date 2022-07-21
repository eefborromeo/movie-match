module TMDB
    module Api
        class Client
            BASE_URL = "https://api.themoviedb.org/".freeze
            API_KEY = Rails.application.credentials.dig(:tmdb, :api_key)
            BEARER_TOKEN = Rails.application.credentials.dig(:tmdb, :bearer_token)

            def request_token
                connection = Faraday.new(
                    url: BASE_URL, 
                    params: {},
                    headers: {
                        "Authorization" => "Bearer #{BEARER_TOKEN}",
                        "Content-Type" => "application/json;charset=utf-8"
                })
                response = connection.get('3/authentication/token/new', {"api_key" => API_KEY}, {
                    "Content-Type" => "application/json;charset=utf-8",
                    "Authorization" => "Bearer #{BEARER_TOKEN}",
                } )
                JSON.parse(response.body)["request_token"]
            end

            def session_id(token)
                connection = Faraday.new(
                    url: BASE_URL, 
                    params: {},
                    headers: {
                        "Authorization" => "Bearer #{BEARER_TOKEN}",
                        "Content-Type" => "application/json;charset=utf-8"
                })
                response = connection.post("3/authentication/session/new?api_key=#{API_KEY}&request_token=#{token}")
                JSON.parse(response.body)["session_id"]
            end

            def get_genre
                connection = Faraday.new(
                    url: BASE_URL, 
                    params: {},
                    headers: {
                        "Authorization" => "Bearer #{BEARER_TOKEN}",
                        "Content-Type" => "application/json;charset=utf-8"
                })
                response = connection.get("3/genre/movie/list?api_key=#{API_KEY}")
                JSON.parse(response.body)
            end
        

            # private

            # def send_request(method, resource, body, parameters)
            #     connection = Faraday.new(
            #         url: BASE_URL, 
            #         params: {},
            #         headers: {
            #             "Authorization" => "Bearer #{BEARER_TOKEN}",
            #             "Content-Type" => "application/json;charset=utf-8"
            #     })
            #     response = connection.public_send(method, resource, body, parameters, {
            #         "Content-Type" => "application/json;charset=utf-8",
            #         "Authorization" => "Bearer #{BEARER_TOKEN}",
            #     })
            #     JSON.parse(response.body)
            # end
        end
    end
end