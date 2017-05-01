class FermentationsController < ApplicationController
  authorize_resource

  def show
    @fermentation = Fermentation.includes(:products).find(params[:id])
  end
  # 
  # def search
  #   Fermentation.where(name: )
  # end
end
