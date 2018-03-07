class HomeController < ApplicationController
  def index
  end

  def results
  	#check to make sure the contents of out parameters have data, if not stay on root screen
  if params[:term] != nil && params[:location] != nil
  	#clears any previous database to get rid of odl query results
  	@restaurants = Restaurant.all
  	@restaurants.destroy_all

  	query = {
  		:term => params[:terms],
  		:location => params[:location],
  		:limit => 18,
  		:radius => 20000,
  	}

  	headers = {
  		:authorization => "Bearer #{Figaro.env.yelp_token}"
  	}

  	response = HTTParty.get(
		  "https://api.yelp.com/v3/businesses/search", 
		  :query => query,
		  :headers => headers)
  	length = response['businesses'].length
  	count = 0
  	#Loop through our response array of hashes and send the records to our database
  		while count < length do

				@restaurants = Restaurant.create(name: response["businesses"][count]["name"], rating: response["businesses"][count]["rating"], address: response["businesses"][count]["location"]["address1"], address2: response["businesses"][count]["location"]["address2"], address3: response["businesses"][count]["location"]["address3"], city: response["businesses"][count]["location"]["city"], phone: response["businesses"][count]["display_phone"], price: response["businesses"][count]["price"], url: response["businesses"][count]["url"], image: response["businesses"][count]["image_url"] )

			count += 1
		end
			@restaurants = Restaurant.all

  	else
  		redirect_to root_path
  	end

 end

  def test
  	query = {
  		:term => "greek",
  		:location => "Atlanta, GA",
  		:limit => 10
  	}

  	headers = {
  		:authorization => "Bearer #{Figaro.env.yelp_token}"
  	}

  	response = HTTParty.get(
		  "https://api.yelp.com/v3/businesses/search", 
		  :query => query,
		  :headers => headers)
  	length = response['businesses'].length
  	count = 0

  	@results = []

  	while count < length do

	        puts response["businesses"][count]["name"], response["businesses"][count]["location"]["display_address"], response["businesses"][count]["display_phone"], response["businesses"][count]["rating"]
		
			count += 1
		end

		response["businesses"].each do |business|
			@results.push(business)
  end

  puts @results

 end 
end
