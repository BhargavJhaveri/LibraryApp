class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
    	t.text :isbn
    	t.text  :email

      t.timestamps
    end
  end
end
