class CreateLibraryMembers < ActiveRecord::Migration
   def up
    create_table :library_members do |t|
      t.column "first_name",:string, :limit =>25
      t.string "Last_name",:limit =>50
      t.string "email", :default=>"",:null =>false
      t.string "password",:limit => 40
      t.timestamps
    end

  

  def down
  	drop_table :library_members
  end

  end
end
