class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
    	t.string :ISBN
    	t.string  :email

      t.timestamps
    end
  end
end
