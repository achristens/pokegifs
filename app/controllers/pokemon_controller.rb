class PokemonController < ApplicationController

  def show
    poke_res  = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")
    poke_body = JSON.parse(poke_res.body)
    name = poke_body["name"]
    id   = poke_body["id"]
    types = poke_body["types"].map { |type| { name: type["type"]["name"] } }

    res = HTTParty.get("https://api.giphy.com/v1/gifs/random?api_key=#{ENV["GIPHY_KEY"]}&tag=#{name}")
    body = JSON.parse(res.body)
    if body == { "message" => "Invalid authentication credentials" }
      gif_url = "Currently unavailable"
    else
      gif_url = body["data"]["url"]
    end

    render json:{
      "id:"      => id,
      "name:"    => name,
      "types:"   => types.map {|type| type[:name]},
      "gif_url:" => gif_url
    }


  end

end
