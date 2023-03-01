class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  

  # GET /posts or /posts.json
  def index
    @posts = Post.order(created_at: :desc).paginate(page: params[:page], per_page: 5)
  end
  

  # GET /posts/1 or /posts/1.json
  def show
    if Current.user
      if cookies["post_#{params[:id]}"] != 'true'
        # Find the post
        @post = Post.find(params[:id])
  
        # If found, increment views by 1 and set cookie to indicate the post has been viewed
        if @post.present?
          @post.increment!(:views)
          cookies["post_#{params[:id]}"] = 'true'
        end
      end
    else 
      redirect_to root_path, alert: "Please log in to continue"
    end
  end
  
  
  

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    if Current.user # check if a user is logged in
      if @post.user_id == Current.user.id # check if the post belongs to the current user
        render :edit
      else
        redirect_to post_path(@post), alert: "You can only edit your own posts."
      end
    else 
      redirect_to root_path, alert: "Please log in to continue"
    end
  end
  
  

  # POST /posts or /posts.json
  def create
    if Current.user # check if user is logged in
      @post = Current.user.posts.build(post_params) # build the post with the current user
      respond_to do |format|
        if @post.save
          format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to posts_path, alert: "You need to log in or sign up before continuing." # redirect to login page if user is not logged in
    end
  end
  

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    if @post.user_id == Current.user.id # check if the post belongs to the current user
      @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      redirect_to post_path(@post), alert: "You can only delete your own posts."
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body , :photo, :views, :user_id)
    end
end
