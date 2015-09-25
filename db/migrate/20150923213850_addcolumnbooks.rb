class Addcolumnbooks < ActiveRecord::Migration
  def change
       add_reference :library_books,:library_members,index: true,foreign_key: true
  end
end
