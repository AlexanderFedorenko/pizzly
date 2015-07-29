class LinksController < ApplicationController
  # GET /
  def index
    @link = Link.new
    @links = Link.all
  end

  # GET /abc
  def show
    if @link.nil?
      redirect_to links_path
    else
      @link.turn_counter
      redirect_to @link.origin
    end
  end

  # POST /
  def create
    @link = Link.new(link_params)

    if @link.save
      redirect_to @link
    else
      render :new
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:origin)
    end
end
