class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_gossip
  before_action :set_comment, only: [:show, :edit, :update, :destroy, :like, :unlike]

  def show
  end

  def create
    @gossip = Gossip.find(params[:gossip_id])
    @comment = @gossip.comments.build(comment_params)
    @comment.user = current_user
  
    if @comment.save
      redirect_to @gossip, notice: "Commentaire ajouté avec succès."
    else
      render 'gossips/show'
    end
  end

  def edit
  end

  def update
    if @comment.user == current_user
      if @comment.update(comment_params)
        redirect_to gossip_path(@gossip), notice: "Commentaire mis à jour."
      else
        render :edit, alert: "Erreur lors de la mise à jour."
      end
    else
      redirect_to gossip_path(@gossip), alert: "Vous ne pouvez pas modifier ce commentaire."
    end
  end

  def destroy
    if @comment.user == current_user
      @comment.destroy
      redirect_to gossip_path(@gossip), notice: "Commentaire supprimé."
    else
      redirect_to gossip_path(@gossip), alert: "Vous n'avez pas la permission de supprimer ce commentaire."
    end
  end

  # Ajout des actions like / unlike
  def like
    @comment.likes.find_or_create_by(user: current_user)
    redirect_to gossip_path(@gossip)
  end

  def unlike
    like = @comment.likes.find_by(user: current_user)
    like&.destroy
    redirect_to gossip_path(@gossip)
  end

  private

  def set_gossip
    @gossip = Gossip.find(params[:gossip_id])
  end

  def set_comment
    @comment = @gossip.comments.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to gossip_path(@gossip), alert: "Commentaire introuvable ou n'appartient pas à ce potin." 
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end





  