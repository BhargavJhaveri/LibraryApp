class CreateLibraryMembers < ActiveRecord::Migration
  def change
    create_table :library_members do |t|
    	t.string "email" :limit =>50
    	t.string "first_name" :limit=>50
    	t.string "last_name" :limit =>50
    	t.string "hashedpassword" limit =>50
 
      t.timestamps
    end
  end
end
