class CreateHistorialCompras < ActiveRecord::Migration[7.0]
  def change
    create_table :historial_compras do |t|
      t.integer :ingrediente_id
      t.integer :cantidad_comprada

      t.timestamps
    end
  end
end
