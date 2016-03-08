class PronosticsController < ApplicationController
  before_action :set_pronostic, only: [:show, :edit, :update, :destroy]
  before_filter :is_member


  respond_to :html

  def is_member
    @ligue = Ligue.find(params[:ligue_id])
    @tournament = Tournament.find(params[:tournament_id])
    @members = @ligue.members
    if  !current_user.ligues.include?(@ligue)
      flash[:error] = "Vous n'etes pas inscrit dans cette ligue"
      redirect_to tournament_ligues_url(@tournament)
    else
      @members.each do |member|
        if member.user_id == current_user.id && member.status != "Admis"
          flash[:error] = "Vous n'etes pas inscrit dans cette ligue"
          redirect_to tournament_ligues_url(@tournament)
        end
      end
    end
  end

  def index
    @pronostics = Pronostic.all
    respond_with(@pronostics)
  end

  def show
    respond_with(@pronostic)
  end

  def new
    @pronostic = Pronostic.new
    @ligue = Ligue.find(params[:ligue_id])
    @bet = Bet.find(params[:bet_id])
    @tournament = Tournament.find(params[:tournament_id])
  end

  def edit
  end

  def create

    @tournament = Tournament.find(params[:tournament_id])
    @ligue = Ligue.find(params[:ligue_id])
    @bet = Bet.find(params[:bet_id])
    @tournament = Tournament.find(params[:tournament_id])

    @pronostic = Pronostic.new(pronostic_params)
    @pronostic.user_id = current_user.id
    @pronostic.tournament_id =  @tournament.id
    @pronostic.ligue_id =  @ligue.id
    @pronostic.bet_id =  @bet.id


    respond_to do |format|
      if @pronostic.save
        format.html { redirect_to tournament_ligue_path(@ligue.tournament_id, @ligue.id), notice: 'Pronostic was successfully created.' }
        format.json { render :show, status: :created, location: @ligue }
      else
        format.html { render :new }
        format.json { render json: @ligue.errors, status: :unprocessable_entity }
      end
    end

  end

  def update
    @pronostic.update(pronostic_params)
    respond_with(@pronostic)
  end

  def destroy
    @pronostic.destroy
    respond_with(@pronostic)
  end

  private
    def set_pronostic
      @pronostic = Pronostic.find(params[:id])
    end

    def pronostic_params
      params.require(:pronostic).permit(:tournament_id, :user_id, :bet_id, :ligue_id, :score1, :score2)
    end
end
