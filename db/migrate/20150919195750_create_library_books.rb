class CreateLibraryBooks < ActiveRecord::Migration
  def change
    create_table :library_books do |t|
    	
      t.string "ISBN",:limit =>50
      t.string "TITLE", :default=>"",:null =>false
      t.string "DESCRIPTION",:limit => 40
       t.string "AUTHORS",:limit => 40
        t.string "STATUS",:limit => 40
      
      t.timestamps
    end
  end
end
