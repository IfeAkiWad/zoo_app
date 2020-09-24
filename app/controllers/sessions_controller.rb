class SessionsController < ApplicationController

        def create
            
          @user = User.find_or_create_by(uid: auth['uid']) do |u|
            u.name = auth['info']['name']
            u.email = auth['info']['email']
            u.image = auth['info']['image']
          end
          
          if @user
            session[:user_id] = @user.id
            redirect_to user_path(@user)
          else
          @user = User.find_by(:name => params[:user][:name])
            if @user && @user.authenticate(params[:password])
              session[:user_id] = @user.id
              redirect_to user_path(@user)
            else
                 render :new
            end
           #binding.pry
          end
          
        end

        def destroy
          if current_user
            session.delete :user_id
            redirect_to root_url
          end
        end
       
        private
       
        def auth
          request.env['omniauth.auth']
        end
      
end