class CreateLibraryBooks < ActiveRecord::Migration
  def change
    create_table :library_books do |t|
    	
      t.text "ISBN",:limit =>50
      t.text "TITLE", :default=>"",:null =>false
      t.text "DESCRIPTION",:limit => 40
       t.text "AUTHORS",:limit => 40
        t.text "STATUS",:limit => 40
      
      t.timestamps
    end
  end
end
