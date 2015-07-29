class LinksController < ApplicationController
  # GET /
  def index
    @link = Link.new
    @links = Link.all
  end

  # GET /abc
  # GET /abc+
  def show
    @link = Link.find_by_url(params[:id].gsub(/\++$/, ''))
    if @link.nil?
      redirect_to links_path
    else
      if params[:id][-1] == '+'
        render 'show'
      else
        @link.turn_counter
        redirect_to @link.origin
      end
    end
  end

  # POST /
  def create
    @link = Link.new(link_params)

    if @link.save
      redirect_to link_path "#{@link.url}+"
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
