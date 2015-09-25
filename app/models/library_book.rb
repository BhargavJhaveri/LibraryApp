# This is the Library Book management model class.
class LibraryBook < ActiveRecord::Base
	belongs_to :LibraryMember #"foreign key"
	validates_presence_of :ISBN
    validates_presence_of :TITLE
    validates_presence_of :AUTHORS
    validates_presence_of :DESCRIPTION

    validates_uniqueness_of :ISBN,:message => "You cannot add book with same ISBN"
    scope :sorted,lambda{order("library_books.title ASC")}
	scope :newest_first,lambda{order("library_books.created_at DESC")}
	scope :search,lambda{|query,category| where(["#{category} like ?","%#{query}%"])}
end
