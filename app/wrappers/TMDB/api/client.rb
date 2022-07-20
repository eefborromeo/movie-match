module TMDB
    module Api
        class Client
            BASE_URL = "https://api.themoviedb.org/".freeze
            BEARER_TOKEN = Rails.application.credentials.dig(:tmdb, :bearer_token)

            def request_token
                connection = Faraday.new(
                    url: BASE_URL, 
                    params: {},
                    headers: {
                        "Authorization" => "Bearer #{BEARER_TOKEN}",
                        "Content-Type" => "application/json;charset=utf-8"
                })
                response = connection.post(
                    '4/auth/request_token', 
                    '{"redirect_to": "http://127.0.0.1:3000/user/approved"}', 
                    {
                        "Content-Type" => "application/json;charset=utf-8",
                        "Authorization" => "Bearer #{BEARER_TOKEN}",
                    } 
                )
                body = JSON.parse(response.body)
                body["request_token"]
            end

            def access_token(token)
                connection = Faraday.new(
                    url: BASE_URL, 
                    params: {},
                    headers: {
                        "Authorization" => "Bearer #{BEARER_TOKEN}",
                        "Content-Type" => "application/json;charset=utf-8"
                })
                response = connection.post(
                    '4/auth/access_token', 
                    "{'request_token': '#{token}'}", 
                    {
                        "Content-Type" => "application/json;charset=utf-8",
                        "Authorization" => "Bearer #{BEARER_TOKEN}",
                    } 
                )
                JSON.parse(response.body)
            end
        end
    end
end