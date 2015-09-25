class CreateLibraryMembers < ActiveRecord::Migration
   def up
    create_table :library_members do |t|
      t.column "first_name",:text, :limit =>25
      t.text "Last_name",:limit =>50
      t.text "email", :default=>"",:null =>false
      t.text "password",:limit => 40
      t.timestamps
    end

  

  def down
  	drop_table :library_members
  end

  end
end
