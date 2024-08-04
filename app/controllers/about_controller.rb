class AboutController < ApplicationController
  def show
    @page = AdminUpdatePage.find_by(title: "About")
  end
end
