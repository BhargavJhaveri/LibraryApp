class CreateLibraryBooks < ActiveRecord::Migration
  def change
    create_table :library_books do |t|
    	
      t.text "isbn",:limit =>50
      t.text "title", :default=>"",:null =>false
      t.text "description",:limit => 40
       t.text "authors",:limit => 40
        t.text "status",:limit => 40
      
      t.timestamps
    end
  end
end
