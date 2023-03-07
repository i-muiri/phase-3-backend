class AppController < Sinatra::Base
    set :default_content_type, 'application/json'
  
   
  # Add your routes here
  get '/movies' do
    movies = Movie.all.order(year: :desc)
    movies.to_json
end

post '/create' do
    begin
      data = JSON.parse(request.body.read)
      data["fetched_first"] = false
      movies = Movie.create(data)
      status 201
      { movies: movies.to_json }.to_json
    rescue JSON::ParserError => e
      status 400
      { error: "Invalid JSON: #{e.message}" }.to_json
    rescue => e 
      logger.error e.message
      status 500
      { error: "Internal server error" }.to_json
    end
  end

get '/search' do
    query = params[:query]
    matching_movies = Movie.select{ |movie| movie[:title].include?(query) || movie[:year].to_s.include?(query) }
    matching_movies.to_json
    end

delete '/movies/destroy/:id' do
    begin
    movie = Movie.find(params[:id])
    movie.destroy
rescue => e 
    [422, {
        error: e.message
}.to_json]
end
end

put '/movies/update/:id' do 
    data = JSON.parse(request.body.read)
    begin
        movies = Movie.find(params[:id])
        movies.update(data)
            { message: "updated successfully" }.to_json
        rescue => e 
            [422, {
                error: e.message
        }.to_json]
    end
end

end