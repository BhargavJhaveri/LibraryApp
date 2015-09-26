class LibraryMembersController < ApplicationController
  before_action :logged_in,:except => [:new,:create]


  def new
    @member=LibraryMember.new
  end

  def create
    @member=LibraryMember.new(member_params)

    if @member.save
      session[:member_id]=@member.id
      session[:email]=@member.email

      redirect_to(:action => 'show',:id => @member.id.to_s)
    else
      render('new')

      end   
  end

  def edit
    @member=LibraryMember.find_by_id(params[:id])
  end

  def update
    @member=LibraryMember.find_by_id(params[:id])
    if  @member.update(member_params)
       redirect_to(:action => 'show',:id => @member.id.to_s)
    else
      @member=LibraryMember.find_by_id(params[:id])
      render('edit')
    end

        
  end

  def delete
  end

  def destroy
  end

  def index
    @members=LibraryMember.order("created_at ASC")
  end

  def show
  
    @member=LibraryMember.find_by_id(params[:id])

  end

  def checkout
    @member=LibraryMember.find_by_id(params[:id])
    i=@member.email
    @find=Relationship.where(email: i).order("created_at DESC")
    @find1=[]
    @array=[]
    @find.each do |book|

       bookobject=LibraryBook.find_by isbn: book.isbn
         @find1<<bookobject
       if bookobject.status=='checked_out' && book.status=='yes'
          @array <<bookobject
        end
      end
    end

  

  private
  def member_params
    params.require(:member).permit(:first_name,:Last_name,:email,:password)
  end
end
