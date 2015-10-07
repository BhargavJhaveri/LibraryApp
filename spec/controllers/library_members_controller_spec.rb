require 'rails_helper'

describe LibraryMembersController do
  it "populates an array of contacts" do
    @member = FactoryGirl.create(:LibraryMember)
    get :index
    assigns(@members).should include([@member])

  end
  
  it "renders the :index view" do
    get :index
    response.should render_template :index
  end
end

describe AdminController do
  it "assigns the requested contact to @contact" do
    admin = FactoryGirl.create(:admin)
    get :show, id: admin
    assigns(:admin).should eq(admin)
  end
  
  it "renders the #show view" do
    get :show, id: FactoryGirl.create(:admin)
    response.should render_template :show
  end
end