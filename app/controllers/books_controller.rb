class BooksController < ApplicationController
  def new
    @admin=LibraryAdmin.find_by(:email => params[:email])
     @book=LibraryBook.new
  end

  def create
     @book=LibraryBook.new(book_params)
     @admin=LibraryAdmin.find_by(:email => params[:email])

    if @book.save
     
      flash[:notice]="You have sucessfully added a book"
      redirect_to(:action => 'show',:id => @book.id.to_s,:email =>@admin.email)
    else
      flash[:notice]="The book with isbn is already present"
      render('new')

      end   
  end
 def edit
@admin=LibraryAdmin.find_by(:email => params[:email])
    @book=LibraryBook.find_by_id(params[:id])
  end

  def update
    @admin=LibraryAdmin.find_by(:email => params[:email])
    @book=LibraryBook.find_by_id(params[:id])
    if  @book.update(book_params)
      flash[:notice]="you have sucessfully update the book"
       redirect_to(:action => 'show',:id => @book.id.to_s,:email => @admin.email)
    else
      @book=LibraryBook.find_by_id(params[:id])
      flash[:notice]="Try Again"
      render('edit')
    end

        
  end

  def delete
    @admin=LibraryAdmin.find_by(:email => params[:email])
    @book=LibraryBook.find_by_id(params[:id])
  end

  def destroy
    @admin=LibraryAdmin.find_by(:email => params[:email])
     LibraryBook.find_by_id(params[:id]).destroy
     flash[:notice]="sucessfully destroyed the book"
     redirect_to(:action =>'index',:id =>@admin.id.to_s)
  end

  def index
    @books=LibraryBook.order("created_at ASC")
    @admin=LibraryAdmin.find_by_id(params[:id])
  end

  def show
    @admin=LibraryAdmin.find_by(:email => params[:email])
    @book=LibraryBook.find_by_id(params[:id])

  end
  
   def search
    @member=LibraryMember.find_by_id(params[:id])
    if params[:search]
      @books=LibraryBook.search(params[:search],params[:CATEGORIES]).order("created_at DESC")
      else
        @books=LibraryBook.order("created_at DESC")
      end
  end
  def checkoutbook

    @book=LibraryBook.find_by_id(params[:id])
    
    @book.status='checked_out'
    @book.save
    @member=LibraryMember.find_by(:email => params[:email])
    @member.library_books << @book
    k=@book.isbn
    l=@member.email
    Relationship.create(:isbn => k,:email =>l,:status =>'yes')
    flash[:notice]="you have sucessfully checked out a book"
    redirect_to(:controller =>'library_members',:action =>'show',:id => @member.id.to_s)
  end
  def checkin
    @book=LibraryBook.find_by_id(params[:id])
    @member=LibraryMember.find_by(:email => params[:email])
    @book.status='check_in'
    @book.save
    @member.library_books.delete(@book)
    k=@book.isbn
    @relation=Relationship.where(:isbn =>k)
    @relation.each do |relation| 
      relation.status='no'
      relation.save
    end
    redirect_to(:controller =>'library_members',:action =>'show',:id => @member.id.to_s)
    flash[:notice]="you have sucessfully checked in a book"
  end

    
    

  def checkouthistory
    @book=LibraryBook.find_by_id(params[:id])
    @find=Relationship.where(:isbn => @book.isbn).order("created_at DESC")

      end


  private
  def book_params
    params.require(:book).permit(:isbn,:title,:authors,:description,:status)
  end
end
