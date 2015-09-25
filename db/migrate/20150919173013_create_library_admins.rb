class CreateLibraryAdmins < ActiveRecord::Migration
  def up
    create_table :library_admins do |t|
      t.column "first_name",:text, :limit =>25
      t.text "Last_name",:limit =>50
      t.text "email", :default=>"",:null =>false
      t.text "password",:limit => 40
      t.timestamps
    end

  end

  def down
  	drop_table :library_admins
  end

end
