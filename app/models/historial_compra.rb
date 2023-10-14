class HistorialCompra < ApplicationRecord
  def self.ingredientes
    JSON.parse(Net::HTTP.get(URI("http://bodegaservice:3000/ingrediente")))
  end
end
