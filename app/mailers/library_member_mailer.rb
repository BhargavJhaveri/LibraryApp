class LibraryMemberMailer < ActionMailer::Base
  default from: "notification@library.com"


  def checkin_email(user,book)
  	@book=book
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Book available')
  end
end


