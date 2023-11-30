class PagesController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    @view = params[:view] || 'default'

    respond_to do |format|
      format.html do
        if request.headers["Turbo-Frame"]
          render partial: "pages/#{@view}", layout: false
        else
          render :dashboard
        end
      end
    end
  end
end
