class HometownsController < ApplicationController

  def home
    
    if params[:city]
      @city = params[:city]
    else
      @city = "san francisco"
    end
    
    if params[:state]
      @state = params[:state]
    else
      @state = "CA"
    end        




    @weathers = Unirest.get("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22#{@city}%2C%20#{@state}%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys").body
 

    @current_location = @weathers["query"]["results"]["channel"]["location"]

    @current_forecast = @weathers["query"]["results"]["channel"]["item"]["condition"]

    @five_day_forecast = @weathers["query"]["results"]["channel"]["item"]["forecast"]

    @description = @weathers["query"]["results"]["channel"]["item"]["description"] 
  end


end
