class AlterAdmins < ActiveRecord::Migration
  def up
  	add_column("library_admins","username",:text,:limit=>25,:after=>"email")
  	rename_column("library_admins" ,"password","hashed_password")
  	puts "**adding an index"
  	add_index("library_admins","username")
  end
  def down
  	remove_index("library_admins","username")
  	rename_column("library_admins" ,"hashed_password","password")
  	
     remove_column("library_admins","username")
  	
  end

end
