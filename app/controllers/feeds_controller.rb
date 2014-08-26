class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @feeds = Feed.all
  end

  def show
  end

  def new
    @feed = current_user.feeds.build
  end

  def edit
  end

  def create
    @feed = current_user.feeds.build(feed_params)
    if @feed.save
        redirect_to @feed, notice: 'Feed was successfully created.' 
      else
        render :new 
      end
    end

  def update
      if @feed.update(feed_params)
        redirect_to @feed, notice: 'Feed was successfully updated.' 
      else
        render :edit 
      end
    end
  

  def destroy
    @feed.destroy
      redirect_to feeds_url, notice: 'Feed was successfully destroyed.' 
    end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed
      @feed = Feed.find(params[:id])
    end

    def correct_user
      @feed = current_user.feeds.find_by(id: params[:id])
      redirect_to feeds_path, notice: "Not authorized to edit this feed." if @feed.nil?
    end  

    # Never trust parameters from the scary internet, only allow the white list through.
    def feed_params
      params.require(:feed).permit(:description)
    end
   end 

