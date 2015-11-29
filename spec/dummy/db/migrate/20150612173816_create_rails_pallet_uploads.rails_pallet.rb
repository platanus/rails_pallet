# This migration comes from rails_pallet (originally 20150612152328)
class CreateRailsPalletUploads < ActiveRecord::Migration
  def change
    create_table :rails_pallet_uploads do |t|
      t.timestamps null: false
    end
  end
end
