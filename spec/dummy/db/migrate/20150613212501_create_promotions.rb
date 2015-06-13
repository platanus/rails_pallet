class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|

      t.timestamps null: false
    end
  end
end
