class BetsController < ApplicationController
  before_action :set_bet, only: [:show, :edit, :update, :destroy]
  before_filter :only_admin, only: [:new, :edit, :update, :destroy]


  respond_to :html

  def index
    @tournament = Tournament.find(params[:tournament_id])

    @matchs_du_jour = @tournament.bets.where("start_at > ? AND start_at < ? ",DateTime.now.beginning_of_day, DateTime.now.end_of_day).order(:start_at)

    @matchs_termines = @tournament.bets.where("start_at < ? ",DateTime.now.to_date).order(:start_at)

    @matchs_a_venir = @tournament.bets.where("start_at > ? ",DateTime.now.to_date).order(:start_at)
  end

  def show
    respond_with(@bet)
  end

  def new
    @bet = Bet.new
    respond_with(@bet)
  end

  def edit
  end

  def create
    @bet = Bet.new(bet_params)
    @bet.save
    respond_with(@bet)
  end

  def update
    @bet.update(bet_params)
    respond_with(@bet)
  end

  def destroy
    @bet.destroy
    respond_with(@bet)
  end

  private
    def set_bet
      @bet = Bet.find(params[:id])
    end

    def bet_params
      params.require(:bet).permit(:start_at, :score1, :score2, :equipe1_id, :equipe2_id, :global_result_point, :result_point)
    end
end
