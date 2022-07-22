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
end
