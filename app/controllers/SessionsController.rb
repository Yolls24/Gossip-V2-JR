class SessionsController < ApplicationController
    def new
    end
  
    def create
      user = User.find_by(email: params[:email])
  
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to root_path, notice: "Connecté avec succès"
      else
        flash.now[:alert] = "Email ou mot de passe invalide"
        render :new
      end
    end
  
    def destroy
      session.delete(:user_id)
      redirect_to root_path, notice: "Déconnecté"
    end
  end
  
  