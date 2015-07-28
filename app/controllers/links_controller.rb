class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]

  # GET /
  def index
    @link = Link.new
    @links = Link.all
  end

  # GET /abc
  def show
  end

  # POST /
  def create
    @link = Link.new(link_params)

    if @link.save
      redirect_to @link, notice: 'Link was successfully created.'
    else
      render :new
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find_by_url(params[:id])
      if @link.nil?
        redirect_to root_path
      else
        redirect_to @link.origin
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:origin, :url)
    end
end
