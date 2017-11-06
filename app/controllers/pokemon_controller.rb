class PokemonController < ApplicationController

  def show
    poke_res  = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")
    poke_body = JSON.parse(poke_res.body)
    name = poke_body["name"]
    id   = poke_body["id"]
    types = poke_body["types"].map { |type| { name: type["type"]["name"] } }

    res = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_KEY"]}&q=#{name}&rating=g")
    body = JSON.parse(res.body)
    gif_url = body["data"][0]["url"]


    # byebug
    render json:{
      "id:"      => id,
      "name:"    => name,
      "types:"   => types.map {|type| type[:name]},
      "gif_url:" => gif_url
    }
  end

end
