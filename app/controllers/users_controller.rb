class UsersController < ApplicationController
  before_action :forbid_login_user,{only:[:new,:create,:login_form,:login]}
  before_action :authenticate_user,{only:[:index,:logout,:show,:edit,:update,:likes]}
  before_action :ensure_correct_user,{only:[:edit,:update]}

  def index
    @users=User.search(params[:search])
  end

  def new
  end


  def create
    @user=User.new(
      name: params[:name],
      password: params[:password],
      image_name: "duel.jpg"
    )
    if @user.save
      session[:user_id]=@user.id
      redirect_to("/posts/index")
    else
      @error_message="入力情報が間違っています"
      render("users/new")
    end
  end

  def login_form
  end

  def login
    @user=User.find_by(
      name: params[:name]
    )
    if @user && @user.authenticate(params[:password])
      session[:user_id]=@user.id
      redirect_to("/posts/index")
    else
      @error_message="入力情報が間違っています"
      render("users/login_form")
    end
  end

  def logout
    session[:user_id]=nil
    redirect_to("/users/login_form")
  end

  def show
    @user=User.find_by(id: params[:id])
    @posts=Post.where(user_id: params[:id])
  end

  def edit
    @user=User.find_by(id: params[:id])
      
  end

  def update
    @user=User.find_by(id: params[:id])
    @user.name=params[:name]

    if params[:image]
      @user.image_name="#{@user.id}.jpg"
      image=params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end

    if params[:duel_id]
      @user.duel_id=params[:duel_id]
    end

    if params[:profile]
      @user.profile=params[:profile]
    end

    if @user.save
      redirect_to("/users/#{@user.id}")
    else
      @error_message="ユーザー名を入力して下さい"
      render("users/edit")
    end
  end

  def likes
    @user=User.find_by(id: params[:id])
    @likes=Like.where(user_id: @user.id)
  end

  def ensure_correct_user
    @user=User.find_by(id: params[:id])
    if @current_user.id!=@user.id
      flash[:notice]="権限がありません"
      redirect_to("/posts/index")
    end
  end
end
