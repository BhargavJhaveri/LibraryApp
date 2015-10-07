class Changename < ActiveRecord::Migration
  def self.up
    rename_table :mailer, :mailers
  end

 def self.down
    rename_table :mailers, :mailer
 end
end