class UsersController < ApplicationController
    before_action :authorized, only: [:persist] 

    # authorized action is required before persist action is allowed
    # authorized action is not required for login or creat user
    #before show action the user must be authorized
    # def show
    #   @user = User.find(params[:id])
    #   render json: @user
    # end

    def show
        user=User.find_by(id:params[:id])
        render json: user
    end

    # def index
    #   users=User.all 
    #   render json: users
    # end

    # def update
    #     user=User.find_by(id:params[:id])
    #     user.update(user_params)
    # end
  
    # REGISTER
    def create
      user = User.create(user_params)
      if user.valid?
        partypass = encode_token({user_id: user.id})
        render json: {user: UserSerializer.new(user), token: partypass}
      else
        render json: {error: "Invalid username or password"}
      end
    end
  
    # LOGGING IN
    def login
    #   byebug
      user = User.find_by(username: params[:username])
  
      if user && user.authenticate(params[:password])
        partypass = encode_token({user_id: user.id})
        render json: {user: UserSerializer.new(user), token: partypass}
      else
        render json: {error: "Invalid username or password"}
      end
    end
  
  
    def persist
      partypass = encode_token({user_id: user.id})
      render json: {user: UserSerializer.new(user), token: partypass}
    end
  
    private
  
    def user_params
      params.permit(:username, :password)
    end
  





end
