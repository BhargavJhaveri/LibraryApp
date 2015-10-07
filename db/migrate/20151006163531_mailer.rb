class Mailer < ActiveRecord::Migration
  def change
  	create_table :mailer do |t|
    	
      t.text "isbn",:limit =>50
      t.text "email", :default=>"",:null =>false 
      t.timestamps
  end
end
end

