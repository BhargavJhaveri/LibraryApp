class Passworddigest < ActiveRecord::Migration
  def change
  	add_column("library_members","password_digest",:string,:limit=>40,:after=>"email")
  	remove_column("library_members","password")
  end
end
