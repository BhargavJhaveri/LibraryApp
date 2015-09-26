class AdminController < ApplicationController
  before_action :logged_in_admin 
	def index
    @Admin = LibraryAdmin.find_by_id(session[:admin_id])
    @admin=LibraryAdmin.order("created_at ASC")
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
    @Admin=LibraryAdmin.find_by_id(params[:id]) 
  end
  
  def managebooks
     @admin=LibraryAdmin.find_by_id(params[:id])
    redirect_to(:controller => 'Books',:action =>'index',:id => @admin.id.to_s)
  end
  
  def indexmember
    @members=LibraryMember.order("created_at ASC")
  end
  def createmember
     @member=LibraryMember.new(member_params)

    if @member.save
      flash[:notice]="Sucessfully created a member"
      redirect_to(:controller => 'admin',:action => 'showmember',:id => @member.id.to_s)
    else
      flash[:notice]="Try Again"
      render('newmember')

      end   
  end
  def newmember
    @member=LibraryMember.new
  end
  def showmember
    @member=LibraryMember.find_by_id(params[:id])
  end
  def editmember
     @member=LibraryMember.find_by_id(params[:id])
  end
  def destroymember
     @member=LibraryMember.find_by_id(params[:id])
     @member.destroy
     flash[:notice]="Sucessfully destroyed"
     redirect_to(:action =>'indexmember')
  end
  def deletemember
    @member=LibraryMember.find_by_id(params[:id])
  end
  def updatemember
    @member=LibraryMember.find_by_id(params[:id])
    if  @member.update(member_params)
      flash[:notice]="Sucessfully updated member"
       redirect_to(:action => 'showmember',:id => @member.id.to_s)
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
       bookobject=LibraryBook.find_by ISBN: book.ISBN
       if bookobject.STATUS=='checked_out'
          @array <<bookobject
        end
      end
 
end
 
 def checkouthistory
    @member=LibraryMember.find_by_id(params[:id])
    i=@member.email
    @find=Relationship.where(email: i).order("created_at DESC")
    @array=[]
    @find1=[]
    @find.each do |book|
       bookobject=LibraryBook.find_by ISBN: book.ISBN
       @find1<<bookobject
       if bookobject.STATUS=='checked_out' && book.Status=='yes'
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
    
    @book.STATUS='checked_out'
    @book.save
    @admin=LibraryAdmin.find_by(:email => params[:email])
    @admin.LibraryBooks << @book
    k=@book.ISBN
    l=@admin.email
    Relationship.create(:ISBN => k,:email =>l,:Status =>'yes')

    flash[:notice]="you have Sucessfully checked out a book"

    redirect_to(:controller =>'admin',:action =>'index')
  end

   def checkin
    @book=LibraryBook.find_by_id(params[:id])
    @admin=LibraryAdmin.find_by(:email => params[:email])
    @admin.LibraryBooks.delete(@book)
    @book.STATUS='check_in'
    @book.save
    k=@book.ISBN
    @relation=Relationship.where(:ISBN =>k)
    @relation.each do |relation| 
      relation.Status='no'
      relation.save
   
    
    end
     flash[:notice]="you have sucessfully checked in a book" 
    redirect_to(:controller =>'admin',:action =>'index')
  end

end
private
  def member_params
    params.require(:member).permit(:first_name,:Last_name,:email,:password)
  end


private
  def admin_params
    params.require(:admin).permit(:first_name,:Last_name,:email,:password)
  end



