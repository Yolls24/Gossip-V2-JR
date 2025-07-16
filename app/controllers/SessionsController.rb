class SessionsController < ApplicationController
  include SessionsHelper  # <-- Assure-toi que ce helper est bien inclus

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      # Ajout : on stocke les cookies
      remember(user)

      redirect_to root_path, notice: "Connecté avec succès"
    else
      flash.now[:alert] = "Email ou mot de passe invalide"
      render :new
    end
  end

  def destroy
    # Ajout : on efface les cookies et la session
    log_out(current_user)
    redirect_to root_path, notice: "Déconnecté"
  end
end

  
  