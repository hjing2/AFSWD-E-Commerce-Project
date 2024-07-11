class ContactController < ApplicationController
  def show
    @page = AdminUpdatePage.find_by(title: 'Contact')
  end
end
