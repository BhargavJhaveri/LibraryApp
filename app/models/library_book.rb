# This is the Library Book management model class.
class LibraryBook < ActiveRecord::Base
	scope :title ,lambda {where(:title=>"Ruby on rails")}
	scope :title ,lambda {where(:title=>"head first design patterns")}
	scope :sorted,lambda{order("library_books.title ASC")}
	scope :newest_first,lambda{order("library_books.created_at DESC")}
	scope :search,lambda{|query| where(["name LIKE ?","%#{query}#%"])}
end
