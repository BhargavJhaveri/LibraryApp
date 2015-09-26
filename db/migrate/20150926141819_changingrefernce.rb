class Changingrefernce < ActiveRecord::Migration
  def change
  	remove_reference :library_books,:library_members,index: true,foreign_key: true
  	add_reference :library_books,:library_member,index: true,foreign_key: true
  	add_reference :library_books,:library_admin,index: true,foreign_key: true
  end
end
