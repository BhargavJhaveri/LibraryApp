class AdminController < ApplicationController
  before_action :logged_in_admin 
	def index
    @Admin = LibraryAdmin.find_by_id(session[:admin_id])
    @admin=LibraryAdmin.order("created_at ASC")
    @suggest=Suggestion.order("created_at ASC")
  end
  def show
      @admin=LibraryAdmin.find_by_id(params[:id])
  end
  def new
       @admin=LibraryAdmin.new
  end
  
  def create

     @admin=LibraryAdmin.new(admin_params)

    if @admin.save
         flash[:notice]="Admin Sucessfully created"
      redirect_to(:controller => 'admin',:action => 'show',:id => @admin.id.to_s)
    else
      flash[:notice]="Try Again"
      render('new')
    end   

end
  def update
     @admin=LibraryAdmin.find_by_id(params[:id])
    if  @admin.update(admin_params)
        flash[:notice]="Sucessfully updated"
       redirect_to(:action => 'show',:id => @admin.id.to_s)
    else
      @admin=LibraryAdmin.find_by_id(params[:id])
      flash[:notice]="Try Again"
      render('edit')
    end


  end
  def delete
     @Admin = LibraryAdmin.find_by_id(session[:admin_id])
     @admin=LibraryAdmin.find_by_id(params[:id])
     if @admin.email=='vravi2@ncsu.edu' && @admin===@Admin
      flash[:notice]="you cannot delete preconfigured admin or yourself!!!"
      redirect_to(:action =>'index')
     end
    
  end
  def destroy
    
    @admin=LibraryAdmin.find_by_id(params[:id])
    

     @admin.destroy
     flash[:notice]="Sucessfully destroyed!!!"
     redirect_to(:action =>'index')
  end

  def edit
    @admin=LibraryAdmin.find_by_id(params[:id]) 
  end
  
  def managebooks
     @admin=LibraryAdmin.find_by_id(params[:id])
    redirect_to(:controller => 'Books',:action =>'index',:id => @admin.id.to_s)
  end
  
  def indexmember
    @members=LibraryMember.order("created_at ASC")
    @admin=LibraryAdmin.find_by(:email => params[:email])
  end
  def createmember
         @admin=LibraryAdmin.find_by(:email => params[:email])
     @member=LibraryMember.new(member_params)

    if @member.save
      flash[:notice]="Sucessfully created a member"
      redirect_to(:controller => 'admin',:action => 'showmember',:id => @member.id.to_s,:email =>@admin.email)
    else
      flash[:notice]="Try Again"
      render('newmember')

      end   
  end
  def newmember
     @admin=LibraryAdmin.find_by(:email => params[:email])
    @member=LibraryMember.new
  end
  def showmember
     @admin=LibraryAdmin.find_by(:email => params[:email])
    @member=LibraryMember.find_by_id(params[:id])
  end
  def editmember
     @admin=LibraryAdmin.find_by(:email => params[:email])
     @member=LibraryMember.find_by_id(params[:id])
  end
  def destroymember
     @admin=LibraryAdmin.find_by(:email => params[:email])
     @member=LibraryMember.find_by_id(params[:id])
     @member.destroy
     flash[:notice]="Sucessfully destroyed"
     redirect_to(:action =>'indexmember')
  end
  def deletemember
     @admin=LibraryAdmin.find_by(:email => params[:email])
    @member=LibraryMember.find_by_id(params[:id])
  end
  def updatemember
     @admin=LibraryAdmin.find_by(:email => params[:email])
    @member=LibraryMember.find_by_id(params[:id])
    if  @member.update(member_params)
      flash[:notice]="Sucessfully updated member"
       redirect_to(:action => 'showmember',:id => @member.id.to_s,:email => @admin.email)
    else
      @member=LibraryMember.find_by_id(params[:id])
      flash[:notice]="Try Again"
      render('editmember')
    end
end
def checkoutadmin

    @member=LibraryMember.find_by_id(params[:id])
    i=@member.email
    @find=Relationship.where(email: i).order("created_at DESC")
    @array=[]
    @find.each do |book|
       bookobject=LibraryBook.find_by isbn: book.isbn
       if bookobject.status=='checked_out'
          @array <<bookobject
        end
      end
 
end
 
 def checkouthistory
  @admin=LibraryAdmin.find_by(:email => params[:email])
    @member=LibraryMember.find_by_id(params[:id])
    i=@member.email
    @find=Relationship.where(email: i).order("created_at DESC")
    @array=[]
    @find1=[]
    @find.each do |book|
       bookobject=LibraryBook.find_by isbn: book.isbn
       @find1<<bookobject
       if bookobject.status=='checked_out' && book.status=='yes'
          @array <<bookobject
        end
      end
  end 

   def search
    @admin=LibraryAdmin.find_by(params[:id])
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
    @admin=LibraryAdmin.find_by(:email => params[:email])
    @admin.library_books << @book
    k=@book.isbn
    l=@admin.email
    Relationship.create(:isbn => k,:email =>l,:status =>'yes')

    flash[:notice]="you have Sucessfully checked out a book"

    redirect_to(:controller =>'books',:action =>'index',:id => @admin.id.to_s )
  end

   def checkin
    @book=LibraryBook.find_by_id(params[:id])
    @admin=LibraryAdmin.find_by(:email => params[:email])
    if @book.library_admin.present?
     @admin.library_books.delete(@book)
    elsif @book.library_member.present?
      @book.library_member_id='nill'
    end
    @book.status='check_in'
    @book.save
    k=@book.isbn
    @relation=Relationship.where(:isbn =>k)
    @relation.each do |relation| 
      relation.status='no'
      relation.save
   
    
    end
     flash[:notice]="you have sucessfully checked in a book" 
   redirect_to(:controller =>'books',:action =>'index',:id => @admin.id.to_s )
  end
   def checkinmember
    @book=LibraryBook.find_by_id(params[:id])
    @admin=LibraryAdmin.find_by(:email => params[:email])
    if @book.library_admin.present?
     @admin.library_books.delete(@book)
    elsif @book.library_member.present?
      @book.library_member_id='nill'
    end
    @book.status='check_in'
    @book.save
    k=@book.isbn
    @relation=Relationship.where(:isbn =>k)
    @relation.each do |relation| 
      relation.status='no'
      relation.save
   
    
    end
     flash[:notice]="you have sucessfully checked in a book" 
   redirect_to(:controller =>'admin',:action =>'indexmember',:email => @admin.email )
  end


 def addsuggestion
    @suggest=Suggestion.find_by_id(params[:id])
    @admin=LibraryAdmin.find_by(:email => params[:email])
  end

  def createsuggestion
      @admin=LibraryAdmin.find_by(:email => params[:email])
    @suggest=Suggestion.find_by_id(params[:id])
    book=LibraryBook.new
    book.title =suggest_params[:title]
    book.isbn =suggest_params[:isbn]
    book.authors=suggest_params[:authors]
    book.description =suggest_params[:description]
    book.status='check_in'

    if  book.save
      flash[:notice]="Sucessfully added book"
      @suggest.destroy
       redirect_to(:action => 'index')
    else
      @member=LibraryMember.find_by_id(params[:id])
      flash[:notice]="Try Again"
      render('editmember')
    end
  end

  def deletesuggestion
     @suggest=Suggestion.find_by_id(params[:id])
    @suggest.destroy
     redirect_to(:action => 'index')
  end
private
  def member_params
    params.require(:member).permit(:first_name,:Last_name,:email,:password)
  end
private
 def suggest_params
    params.require(:suggest).permit(:isbn,:title,:authors,:description,:email)
  end

end
private
  def admin_params
    params.require(:admin).permit(:first_name,:Last_name,:email,:password)
  end



