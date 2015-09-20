class CreateLibraryAdmins < ActiveRecord::Migration
  def up
    create_table :library_admins do |t|
      t.column "first_name",:string, :limit =>25
      t.string "Last_name",:limit =>50
      t.string "email", :default=>"",:null =>false
      t.string "password",:limit => 40
      t.timestamps
    end

  end

  def down
  	drop_table :library_admins
  end

end
