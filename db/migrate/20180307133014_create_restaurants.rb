class CreateRestaurants < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.integer :rating
      t.string :address
      t.string :address2
      t.string :address3
      t.string :city
      t.string :phone
      t.string :price
      t.string :url
      t.string :image

      t.timestamps
    end
  end
end
