class TournamentsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_tournament, only: [:show, :edit, :update, :destroy]
  before_filter :only_admin, only: [:new, :edit, :update, :destroy]


  # GET /tournaments
  # GET /tournaments.json
  def index
    @tournaments = Tournament.all
  end

  # GET /tournaments/1
  # GET /tournaments/1.json
  def show

  end

  # GET /tournaments/new
  def new
    @tournament = Tournament.new
  end

  # GET /tournaments/1/edit
  def edit
  end

  # POST /tournaments
  # POST /tournaments.json
  def create
    @tournament = Tournament.new(tournament_params)
    respond_to do |format|
      if @tournament.save
        format.html { redirect_to tournaments_path, notice: 'Tournament was successfully created.' }
        format.json { render :show, status: :created, location: @tournament }
      else
        format.html { render :new }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tournaments/1
  # PATCH/PUT /tournaments/1.json
  def update
    @tournament = Tournament.find(params[:id])

    respond_to do |format|
      if @tournament.update(tournament_params)
        @tournament.ligues.each do |ligue|
              @tournament.bets.each do |bet|
                    if !bet.score1.nil? && !bet.not_refresh?
                      bet.pronostics.each do |p|

                        if p.win?
                          member = Member.where('user_id = ?', p.user_id).first
                          if member
                            member.score=member.score+ bet.result_point+ bet.global_result_point
                            member.scoreday=member.scoreday+ bet.result_point+ bet.global_result_point
                            member.pwin = member.pwin + 1
                            member.save
                          end
                        elsif !p.win? && p.global_win?
                          member = Member.where('user_id = ?', p.user_id).first
                          if member
                            member.score=member.score+ bet.global_result_point
                            member.scoreday=member.scoreday+bet.global_result_point
                            member.pwin = member.pwin + 1
                            member.save
                          end
                        elsif !p.win && !p.global_win?
                          member = Member.where('user_id = ?', p.user_id).first
                          if member
                            member.ploose = member.ploose + 1
                            member.save
                          end

                        end

                      end

                      bet.not_refresh = true
                      bet.save
                    end

              end
        end

        format.html { redirect_to tournaments_path, notice: 'Tournament was successfully updated.' }
        format.json { render :show, status: :ok, location: @tournament }
      else
        format.html { render :edit }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tournaments/1
  # DELETE /tournaments/1.json
  def destroy
    @tournament.destroy
    respond_to do |format|
      format.html { redirect_to tournaments_url, notice: 'Tournament was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tournament
      @tournament = Tournament.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tournament_params
      params.require(:tournament).permit(:name, :start_date, :end_date, :private, :bets_attributes => [:id, :start_at, :equipe1_id, :equipe2_id, :score1,:score2,:global_result_point,:result_point, :_destroy], :teams_attributes => [:id, :name, :_destroy, :players_attributes => [:id, :name, :post, :point, :_destroy]])
    end
end
