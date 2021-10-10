class TopController < ApplicationController
    def main
        if session[:login_uid]
            render 'main'
        else
            render 'login'
        end
    end
    
    def login
        
        if User.find_by(uid: params[:uid])
            
            signup_password = BCrypt::Password.create(params[:pass])
            login_password = BCrypt::Password.new(signup_password)
            if login_password == params[:pass]
                session[:login_uid] = User.find_by(pass: params[:pass])
                redirect_to root_path
            end
            
        else
            render 'login_failed'
        end
    
        
    end
    
    def logout
        session.delete(:login_uid)
        redirect_to root_path
    end

end
