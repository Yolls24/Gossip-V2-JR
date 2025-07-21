class UsersController < ApplicationController
  include SessionsHelper  # Ajout pour accéder à remember()

  def show
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Utilisateur non trouvé."
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id

      # Si l'utilisateur a coché "Se souvenir de moi", on crée les cookies
      remember(@user) if params[:remember_me] == "1"

      redirect_to root_path, notice: "Bienvenue #{@user.first_name} !"
    else
      Rails.logger.info @user.errors.full_messages.join(", ")
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :description, :email, :password, :password_confirmation, :city_id)
  end
end




  