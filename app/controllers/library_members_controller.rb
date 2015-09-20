class LibraryMembersController < ApplicationController
  def new
    
  end

  def create
  end

  def edit
  end

  def update
  end

  def delete
  end

  def destroy
  end

  def index
    @members=LibraryMember.order("created_at ASC")
  end

  def show
  end
end
