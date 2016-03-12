class LiguesController < ApplicationController
  before_action :set_ligue, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_filter :is_member, only: [ :show]
  before_filter :is_ligue_admin, only: [:edit, :update, :destroy ]

  respond_to :html

  def is_member
    @ligue = Ligue.find(params[:id])
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

  def is_ligue_admin
    @ligue = Ligue.find(params[:id])
    @tournament = Tournament.find(params[:tournament_id])
    if   user_signed_in? && current_user.id != @ligue.owner_id
      flash[:error] = "Vous n'etes pas administrateur de cette ligue"
      redirect_to tournament_ligues_url(@tournament)
    end
  end




  def index
    @ligues = Ligue.all
    @tournament = Tournament.find(params[:tournament_id])
  end


  def show
    @tournament = Tournament.find(params[:tournament_id])

    @matchs_du_jour = @tournament.bets.where("start_at > ? AND start_at < ? ",DateTime.now.beginning_of_day, DateTime.now.end_of_day).order(:start_at)

    @matchs_termines = @tournament.bets.where("start_at < ? ",DateTime.now.to_date).order(:start_at)

    @matchs_a_venir = @tournament.bets.where("start_at > ? ",DateTime.now.to_date).order(:start_at)

  end

  def new
    @ligue = Ligue.new
    @tournament = Tournament.find(params[:tournament_id])
  end

  def edit
    @tournament = Tournament.find(params[:tournament_id])
    @members = @ligue.members
  end

  def create
    @tournament = Tournament.find(params[:tournament_id])
    @ligue = Ligue.new(ligue_params)
    @ligue.owner_id = current_user.id
    @ligue.tournament_id =  @tournament.id

    respond_to do |format|
      if @ligue.save

        @member = Member.new(params[:member])
        @member.user_id = current_user.id
        @member.ligue_id = @ligue.id
        @member.status = "Admis"
        @member.score = 0
        @member.scoreday = 0
        @member.pwin = 0
        @member.ploose = 0
        @member.save

        format.html { redirect_to tournament_ligues_path, notice: 'Ligue was successfully created.' }
        format.json { render :show, status: :created, location: @ligue }
      else
        format.html { render :new }
        format.json { render json: @ligue.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
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

  def destroy
    @tournament = Tournament.find(params[:tournament_id])

    @ligue.destroy
    respond_to do |format|
      format.html { redirect_to tournament_ligues_url(@tournament), notice: 'Ligue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def classement
    @ligue = Ligue.find(params[:ligue_id])
    @tournament = Tournament.find(params[:tournament_id])
    @members = @ligue.members.order('score DESC')
  end

  private


  def set_ligue
      @ligue = Ligue.find(params[:id])
    end

    def ligue_params
      params.require(:ligue).permit(:name, :owner_id, :tournament_id)
    end
end
