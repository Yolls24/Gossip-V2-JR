module SessionsHelper

    # Crée les cookies pour l'utilisateur et stocke le digest en base
    def remember(user)
      remember_token = SecureRandom.urlsafe_base64
      user.remember(remember_token)
  
      cookies.permanent[:user_id] = user.id
      cookies.permanent[:remember_token] = remember_token
    end
  
    # Efface les cookies et supprime le remember_digest en base
    def forget(user)
      user.update(remember_digest: nil)
      cookies.delete(:user_id)
      cookies.delete(:remember_token)
    end
  
    # Déconnexion complète : session et cookies
    def log_out(user)
      session.delete(:user_id)
      forget(user)
    end
  
    # Retourne l'utilisateur actuellement connecté (via session ou cookies)
    def current_user
      if session[:user_id]
        @current_user ||= User.find_by(id: session[:user_id])
      elsif cookies[:user_id]
        user = User.find_by(id: cookies[:user_id])
        if user && user.remember_digest &&
           BCrypt::Password.new(user.remember_digest).is_password?(cookies[:remember_token])
          session[:user_id] = user.id
          @current_user = user
        end
      end
    end
  end
  