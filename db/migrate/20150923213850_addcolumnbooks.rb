class Addcolumnbooks < ActiveRecord::Migration
  def change
       add_reference :Library_books,:Library_members,index: true,foreign_key: true
  end
end
