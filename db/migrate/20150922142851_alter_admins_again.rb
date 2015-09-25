class AlterAdminsAgain < ActiveRecord::Migration
  def change
  	add_column("library_admins","password_digest",:string,:limit=>40,:after=>"email")
  	remove_column("library_admins","hashed_password")
  end
end
