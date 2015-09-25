class AlterAdminsonce < ActiveRecord::Migration
  def change
  	remove_column("library_admins","hashed_password")
  end
end
