require 'spec_helper'
describe LibraryAdmin do
before do
@admin = LibraryAdmin.new(:first_name => "Example User",:Last_name => "Ravi" ,:email => "user@example.com",:password => "viswa123")
end
subject { @admin }
it {should respond_to(:first_name) }
it {should respond_to(:Last_name) }
it {should respond_to(:email) }
it {should respond_to (:password) }
it { should be_valid }
describe "when first name is not present" do
before { @admin.first_name = "" }
it {should_not be_valid}
end
describe "when Last name is not present" do
before { @admin.Last_name = "" }
it {should_not be_valid}
end
describe "when email is not present" do
before { @admin.email = "" }
it {should_not be_valid}
end
describe "when email is not in proper format" do
	it "should be invalid" do
		emailaddress=%w[user@foo,com user@foo,com user at foo.org example.user@foo.
          foo@bar baz.com foo@bar+baz.com ]
emailaddress.each do |invalid_address|
@admin.email = invalid_address
@admin.should_not be_valid
end
end
end
describe "when email is  in proper format" do
	it "should be valid" do
		emailaddress=%w[user@foo.COM  frst.lst@foo.jp a+b@baz.cn ]
emailaddress.each do |valid_address|
@admin.email = valid_address
@admin.should be_valid
end
end
end
describe "when email address is already taken" do
before do
admin_copy = @admin.dup
admin_copy.save
end
it { should_not be_valid }
end

end