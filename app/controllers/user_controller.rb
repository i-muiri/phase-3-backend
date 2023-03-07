# frozen_string_literal: true

class UserController < AppController
    set :default_content_type, 'application/json'
   
    configure do
          enable :cross_origin
        end 
    # @helper: read JSON body
    before do
      response.headers['Access-Control-Allow-Origin'] = '*'
    end
  
    options "*" do
      response.headers["Allow"] = "GET, PUT, POST, DELETE, OPTIONS"
      response.headers["Access-Control-Allow-Origin"] = "*"
      200
    end
  
    get "/user" do
      users = User.all
      users.to_json
    end
    
      #@method: create a new user
      post '/auth/register' do
        begin
          data = JSON.parse(request.body.read)
          users = User.create(data)
          users.to_json
        rescue => e
            error_response(422, e)
        end
    end
    
      #@method: log in user using email and password
      post '/auth/login' do
        request.body.rewind
        request_payload = JSON.parse(request.body.read)
        email = request_payload['email']
        password = request_payload['password']
        user = User.find{ |u| u[:email] == email && u[:password] == password }
        if user
          {message: "Login success!"}.to_json
        else
          {message: "Invalid email or password"}.to_json
        end
      
      end
    
    end
    