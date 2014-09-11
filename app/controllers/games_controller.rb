class GamesController < ApplicationController

  before_action :find_game, only: [:show, :edit, :update, :destroy]

  def index
    @games = Game.all
  end

  def show

  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create game_params
    if @game.save == true
      redirect_to games_path
      flash[:success] = "Game successfully added."
    else
      render :new
    end
  end

  def edit
    
  end

  def update
    if @game.update_attributes game_params
      redirect_to games_path
    else
      render :edit
    end
  end

  def destroy
    @game.destroy
    redirect_to games_path
  end

  private

  def find_game
    @game = Game.find params[:id]
  end

  def game_params
    params.require(:game).permit(:name)
  end
    
 

end
