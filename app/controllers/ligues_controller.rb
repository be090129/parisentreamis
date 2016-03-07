class LiguesController < ApplicationController
  before_action :set_ligue, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  respond_to :html

  def index
    @ligues = Ligue.all
  end

  def show


  end

  def new
    @ligue = Ligue.new
    @tournament = Tournament.find(params[:tournament_id])
  end

  def edit
    @tournament = Tournament.find(params[:tournament_id])

  end

  def create
    @tournament = Tournament.find(params[:tournament_id])
    @ligue = Ligue.new(ligue_params)
    @ligue.owner_id = current_user.id
    @ligue.tournament_id =  @tournament.id


    respond_to do |format|
      if @ligue.save
        format.html { redirect_to tournament_ligues_path, notice: 'Ligue was successfully created.' }
        format.json { render :show, status: :created, location: @ligue }
      else
        format.html { render :new }
        format.json { render json: @ligue.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @ligue.update(ligue_params)
    respond_with(@ligue)
  end

  def destroy
    @ligue.destroy
    respond_with(@ligue)
  end

  private
    def set_ligue
      @ligue = Ligue.find(params[:id])
    end

    def ligue_params
      params.require(:ligue).permit(:name, :owner_id, :tournament_id)
    end
end
