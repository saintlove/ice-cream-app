class CreateIceCreams < ActiveRecord::Migration[5.1]
  def change
    create_table :ice_creams do |t|
      t.string :flavor
      t.text :description
      t.boolean :vegan
      t.boolean :gluten_free
      t.text :ingredients
      t.text :pairs_with

      t.timestamps
    end
  end
end
