class PlazaMercadoController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'

  def comprar
    ingrediente = params[:ingrediente]
    cantidad_comprada = plaza_mercado(ingrediente)
    @ingredientes = JSON.parse(Net::HTTP.get(URI("http://localhost:3001/ingrediente")))
    ingrediente_id = @ingredientes[ingrediente.capitalize]['id']
    if cantidad_comprada == 0 
      render json: { mensaje: 'Vuelva otro día.' }
    else
      actualizar_disponibilidad_ingredientes(ingrediente_id, cantidad_comprada)
      HistorialCompra.create(ingrediente_id: ingrediente_id, cantidad_comprada: cantidad_comprada)
      render json: {cantidad_comprada: }
    end
  end

  def historial
    @historial = HistorialCompra.all
    render json: @historial
  end

  private

  def plaza_mercado(ingrediente)
    uri = URI.parse("https://utadeoapi-6dae6e29b5b0.herokuapp.com/api/v1/software-architecture/market-place?ingredient=#{ingrediente}")
    http = Net::HTTP.get(uri.host, uri.request_uri)

    json_response = JSON.parse(http)
    result = json_response.dig('data', ingrediente).to_i
  end

  def actualizar_disponibilidad_ingredientes(ingrediente_id, cantidad_comprada)
    uri = URI.parse("http://localhost:3001/ingrediente/#{ingrediente_id}")

    # Utilizar el objeto URI para configurar Net::HTTP
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Put.new(uri.request_uri, 'Content-Type' => 'application/json')

    # Configurar los datos a enviar (cantidad comprada)
    request.body = { cantidad: cantidad_comprada }.to_json

    # Enviar la solicitud PUT para actualizar la cantidad de ingredientes
    response = http.request(request)

    # Analizar la respuesta y devolverla
    JSON.parse(response.body)
  end
end
