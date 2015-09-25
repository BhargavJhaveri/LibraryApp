class BooksController < ApplicationController
  def new
     @book=LibraryBook.new
  end

  def create
     @book=LibraryBook.new(book_params,:STATUS =>'check_in')

    if @book.save
     
      flash[:notice]="You have sucessfully added a book"
      redirect_to(:action => 'show',:id => @book.id.to_s)
    else
      flash[:notice]="The book with ISBN is already present"
      render('new')

      end   
  end
 def edit
    @book=LibraryBook.find_by_id(params[:id])
  end

  def update
    @book=LibraryBook.find_by_id(params[:id])
    if  @book.update(book_params)
      flash[:notice]="you have sucessfully update the book"
       redirect_to(:action => 'show',:id => @book.id.to_s)
    else
      @book=LibraryBook.find_by_id(params[:id])
      flash[:notice]="Try Again"
      render('edit')
    end

        
  end

  def delete
    @book=LibraryBook.find_by_id(params[:id])
  end

  def destroy
     LibraryBook.find_by_id(params[:id]).destroy
     flash[:notice]="sucessfully destroyed the book"
     redirect_to(:action =>'index')
  end

  def index
    @books=LibraryBook.order("created_at ASC")
  end

  def show
  
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
    
    @book.STATUS='checked_out'
    @book.save
    @member=LibraryMember.find_by(:email => params[:email])
    k=@book.ISBN
    l=@member.email
    Relationship.create(:ISBN => k,:email =>l,:Status =>'yes')
    flash[:notice]="you have sucessfully checked out a book"
    redirect_to(:controller =>'library_members',:action =>'show',:id => @member.id.to_s)
  end
  def checkin
    @book=LibraryBook.find_by_id(params[:id])
    @member=LibraryMember.find_by(:email => params[:email])
    @book.STATUS='check_in'
    @book.save
    k=@book.ISBN
    @relation=Relationship.where(:ISBN =>k)
    @relation.each do |relation| 
      relation.Status='no'
      relation.save
    end
    redirect_to(:controller =>'library_members',:action =>'show',:id => @member.id.to_s)
    flash[:notice]="you have sucessfully checked in a book"
  end

    
    

  def checkouthistory
    @book=LibraryBook.find_by_id(params[:id])
    @find=Relationship.where(:ISBN => @book.ISBN).order("created_at DESC")

      end


  private
  def book_params
    params.require(:book).permit(:ISBN,:TITLE,:AUTHORS,:DESCRIPTION)
  end
end
