# app/controllers/gossips_controller.rb
class GossipsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_gossip, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @gossips = Gossip.all
  end

  def show
  end

  def new
    @gossip = Gossip.new
  end

  def create
    @gossip = Gossip.new(gossip_params)
  @gossip.user = current_user

  if @gossip.save
    update_tags(@gossip, params[:tag_list])
    flash[:success] = "Potin créé avec succès !"
    redirect_to gossip_path(@gossip)
  else
    render :new, status: :unprocessable_entity
   end
  end

  def edit
  end

  def update
    if @gossip.update(gossip_params)
      update_tags(@gossip, params[:tag_list])
      flash[:success] = "Potin mis à jour !"
      redirect_to gossip_path(@gossip)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    flash[:success] = "Le potin a bien été supprimé."
    redirect_to root_path
  end

  private

  def gossip_params
    params.require(:gossip).permit(:title, :content)
  end

  def update_tags(gossip, tag_list)
    return unless tag_list
  
    tag_titles = tag_list.split(',').map(&:strip).reject(&:empty?)
    tags = tag_titles.map { |title| Tag.find_or_create_by(title: title.downcase) }
    gossip.tags = tags
  end

  def set_gossip
    @gossip = Gossip.find(params[:id])
  end

  def authorize_user!
    unless @gossip.user == current_user
      flash[:error] = "Tu n'es pas autorisé à modifier ce potin."
      redirect_to gossips_path
    end
  end

  def assign_tags
    raw = gossip_params[:tag_list]
    tag_titles = raw.is_a?(String) ? raw.split(',') : (raw || [])
    @gossip.tags = tag_titles.reject(&:blank?).map do |tag_title|
      Tag.find_or_create_by(title: tag_title.strip.downcase)
    end
  end
end






  