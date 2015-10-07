class Mailer < ActiveRecord::Base
	validates_uniqueness_of :isbn
	validates_uniqueness_of :email
end