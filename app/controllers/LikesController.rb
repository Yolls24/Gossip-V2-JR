class LikesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_gossip
  
    def create
      unless @gossip.likes.exists?(user: current_user)
        @gossip.likes.create(user: current_user)
        flash[:notice] = "Tu as liké ce potin !"
      end
      redirect_to @gossip
    end
  
    def destroy
      like = @gossip.likes.find_by(user: current_user)
      if like
        like.destroy
        flash[:notice] = "Like retiré."
      else
        flash[:alert] = "Tu n'avais pas liké ce potin."
      end
      redirect_to @gossip
    end
  
    private
  
    def set_gossip
      @gossip = Gossip.find(params[:gossip_id])
    end
  end
  
  