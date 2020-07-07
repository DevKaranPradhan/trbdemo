class SessionsController < ApplicationController

  skip_before_action :authorized, only: [:new, :create]

  def new
    render cell(Session::Cell::New, nil, result: result)
    @error = params[:id]
  end

  def create
    # puts "here1-----------"
    # puts "#{params["email"]}#{params["password"]}#samdand,nasdna,msdn,n, ---------------------"
    
    # result = Session::Operation::Create.call(email: params[:email], password: params[:password])
    #   # return render cell(User::Cell::Index, nil, result: result)
    # puts result
    #------ v2
    if Session::Operation::Validate.(email: params[:email], password: params[:password])
      byebug
      @user = User::Operation::Show.(email: params[:email])[:user]
      if @user && @user.authenticate(params[:password])
        token = JsonWebToken.encode(user_id: @user.id)
        session[:token] = token  
        redirect_to welcome_path
      else   
        error = "Invalid Credentials"   
        redirect_to login_path(id:error)
      end
    else   
      error = "One or more fields blank" 
      redirect_to login_path(id:error)
    end
    #------ end

    #------ v1
    # @form = User::Contract::Login.new(User.new)

    # if @form.validate(email: params[:email], password: params[:password])
    #   @user = User.find_by(email: params[:email])
    #   if @user && @user.authenticate(params[:password])
    #     token = JsonWebToken.encode(user_id: @user.id)
    #     puts "#{token}-----------------========"
    #     session[:token] = token  
    #     redirect_to '/welcome'   
    #   else   
    #     error = "Invalid Credentials"   
    #     redirect_to login_path(id:error)
    #   end
    # else   
    #   error = "One or more fields blank" 
    #   redirect_to login_path(id:error)
    # end
    #------ end 

  end

  def login
    
  end

  def welcome

  end

  def destroy      
    
    if session[:token] == nil
      redirect_to logout_path 
    else
      session[:token] = nil
      redirect_to users_path
    end

  end
end
