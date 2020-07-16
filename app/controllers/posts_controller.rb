class PostsController < ApplicationController
  before_action :authenticate_user,{only:[:index,:new,:create,:show,:edit,:update,:destroy,:enjoydecks,:masterdecks,:cupinformation,:friends,:playing]}
  before_action :ensure_correct_user,{only:[:edit,:update]}
  
  def index
    @posts=Post.all.order(reply_id: :desc)
  end

  def new
  end

  def create
    @post=Post.new(
      content: params[:content],
      tag: params[:tag],
    )
    @post.user_id=@current_user.id
    
    
    if @post.save
    if params[:image]
      @post.image_name="#{@post.id}.jpg"
      image=params[:image]
      File.binwrite("public/post_images/#{@post.image_name}", image.read)
      @post.save
    end
      @post.reply_id=@post.id
      @post.save
      redirect_to("/posts/index")
    else
      @error_message="テキストを入力してください"
      render("posts/new")
    end
  end

  def reply_new
    @post=Post.find_by(reply_id: params[:reply_id])
  end

  def reply_create
    @post=Post.new(
      content: params[:content],
      reply_id: params[:reply_id]
    )
    @post.user_id=@current_user.id
    
    
    if params[:image]
      @post.image_name="#{@post.id}.jpg"
      image=params[:image]
      File.binwrite("public/post_images/#{@post.image_name}", image.read)
    end
    
    if @post.save
      redirect_to("/posts/index")
    else
      @error_message="テキストを入力してください"
      render("posts/reply_new")
  end

end

  def show
    @post=Post.find_by(id: params[:id])
    @user=@post.user
    @likes_count=Like.where(post_id: params[:id]).count
  end

  def edit
    @post=Post.find_by(id: params[:id])
  end

  def update
    @post=Post.find_by(id: params[:id])
    if params[:content]
      @post.content=params[:content]
      if params[:tag]
        @post.tag=params[:tag]
        if params[:image]
          @post.image_name="#{@post.id}.jpg"
          image=params[:image]
          File.binwrite("public/post_images/#{@post.image_name}", image.read)
        end
      end
    end

    if @post.save
      redirect_to("/posts/index")
    else
      @error_message="テキストを入力してください"
      render("posts/#{@post.id}")
    end
  end

  def destroy
    @post=Post.find_by(id: params[:id])
    @post.destroy
    redirect_to("/posts/index")
  end

  def enjoydecks
    @posts=Post.where(tag: "デッキ構築(エンジョイ、ネタ)").order(created_at: :desc)
  end

  def masterdecks
    @posts=Post.where(tag: "デッキ構築(マスター帯)").order(created_at: :desc)
  end

  def cupinformation
    @posts=Post.where(tag: "大会情報").order(created_at: :desc)
  end

  def friends
    @posts=Post.where(tag: "フレンド交流").order(created_at: :desc)
  end

  def playing
    @posts=Post.where(tag: "プレイング考察").order(created_at: :desc)
  end

  def ensure_correct_user
    @post=Post.find_by(id: params[:id])
    if @current_user.id!=@post.user.id
      flash[:notice]="権限がありません"
      redirect_to("/posts/index")
    end
  end

end
