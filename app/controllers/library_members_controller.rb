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
   
  end

        
  

  def show
  
    @member=LibraryMember.find_by_id(params[:id])
    if params[:search]
    @books=searchmethod(params[:search],params[:CATEGORIES]).order("created_at ASC").paginate(:per_page => 5, :page => params[:page])
    else
    @books=LibraryBook.order("created_at DESC").paginate(:per_page => 5, :page => params[:page])

    end
  end

   def searchmethod(search,categories)
    @member=LibraryMember.find_by_id(params[:id])
    if search
      @books=LibraryBook.search(search,categories).order("created_at DESC").paginate(:per_page => 5, :page => params[:page])
        @books
      else
        @books=LibraryBook.order("created_at DESC")
        @books
      end
  end
  def suggestnew
     @member=LibraryMember.find_by_id(params[:id])
    @suggest=Suggestion.new

  end
   def createsuggestion
         @member=LibraryMember.find_by(:email => params[:email])
    @suggest=Suggestion.new(suggest_params)

    if @suggest.save
     
      flash[:notice] ="You have made a new suggeestion"
      redirect_to(:action => 'show',:id => @member.id.to_s)
    else
      render('new')

      end   
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

  def suggest_params
    params.require(:suggest).permit(:isbn,:title,:authors,:description,:email)
  end
end
