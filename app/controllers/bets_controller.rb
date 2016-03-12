class BetsController < ApplicationController
  before_action :set_bet, only: [:show, :edit, :update, :destroy]
  before_filter :only_admin, only: [:new, :edit, :update, :destroy]
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
    @bets = Bet.all
    respond_with(@bets)
  end

  def show

    @bet = Bet.find(params[:id])

    @pronostics = @bet.pronostics

    @ligue = Ligue.find(params[:ligue_id])
    @tournament = Tournament.find(params[:tournament_id])
    @members = @ligue.members
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
    @bet = Bet.find(params[:id])
    @tournament = Tournament.find(params[:tournament_id])

    respond_to do |format|
      if @bet.update_attributes(params[:bet])

        format.html { redirect_to @match, notice: 'Match was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end





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
      params.require(:bet).permit(:not_refresh, :start_at, :score1, :score2, :equipe1_id, :equipe2_id, :global_result_point, :result_point)
    end
end
