class PrototypesController < ApplicationController
  before_action :move_to_index, only: [:edit]
  
  
  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = current_user.prototypes.build(prototype_params)
    if @prototype.save
      redirect_to '/'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @name = current_user.name
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end
  
  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    prototype = Prototype.find(params[:id])
    if prototype.update(prototype_params)
       redirect_to "/prototypes/#{prototype.id}"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
   prototype = Prototype.find(params[:id])
   prototype.destroy
   redirect_to root_path
  end
    
end


private
  def prototype_params
    params.require(:prototype).permit(:image, :title, :catch_copy, :concept).merge(user_id: current_user.id)
  end

  def move_to_index
    @prototype = Prototype.find(params[:id])
    unless user_signed_in? && current_user == @prototype.user
      redirect_to action: :index
    end
  end