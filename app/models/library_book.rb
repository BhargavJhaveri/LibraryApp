# This is the Library Book management model class.
class LibraryBook < ActiveRecord::Base
	belongs_to :library_member,:foreign_key => "library_member_id"
	belongs_to :library_admin  ,:foreign_key => "library_admin_id"
	validates_presence_of :isbn
    validates_presence_of :title
    validates_presence_of :authors
    validates_presence_of :description

    validates_uniqueness_of :isbn,:message => "You cannot add book with same ISBN"
    scope :sorted,lambda{order("library_books.title ASC")}
	scope :newest_first,lambda{order("library_books.created_at DESC")}
	scope :search,lambda{|query,category| where(["#{category} like ?","%#{query}%"])}
end
