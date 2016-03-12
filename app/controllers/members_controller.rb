class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  before_filter :is_admin_ligue, only: [:edit, :update, :destroy]


  respond_to :html

  def is_admin_ligue
    @ligue = Ligue.find(params[:ligue_id])
    @tournament = Tournament.find(params[:tournament_id])
    if  current_user.id != @ligue.owner_id
      flash[:error] = "Vous n'etes pas autorise a gerer les membres de la ligue !"
      redirect_to tournament_ligues_url(@tournament)
    end
  end

  def index
    @members = Member.all
    respond_with(@members)
  end

  def show
    respond_with(@member)
  end

  def new
    @member = Member.new
    @ligue = Ligue.find(params[:ligue_id])
    @tournament = Tournament.find(params[:tournament_id])
  end

  def edit
    @member = Member.find(params[:id])

    @tournament = Tournament.find(params[:tournament_id])
    @ligue = Ligue.find(params[:ligue_id])
  end

  def create
    @member = Member.new(member_params)
    @tournament = Tournament.find(params[:tournament_id])
    @ligue = Ligue.find(params[:ligue_id])

    @member.user_id = current_user.id
    @member.status = "Pending"
    @member.score = 0
    @member.scoreday = 0
    @member.pwin = 0
    @member.ploose = 0

    respond_to do |format|
      if @member.save
        format.html { redirect_to tournament_ligues_path(@tournament), notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, location: @ligue }
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @member = Member.find(params[:id])

    @tournament = Tournament.find(params[:tournament_id])
    @ligue = Ligue.find(params[:ligue_id])

    respond_to do |format|
      if params[:admis]
        @member.status = "Admis"
        @member.save
        format.html { redirect_to edit_tournament_ligue_path(@tournament.id, @ligue.id), notice: 'Member was successfully updated.' }
      elsif params[:refused]
        @member.status = "Refused"
        @member.save
        format.html { redirect_to edit_tournament_ligue_path(@tournament.id, @ligue.id), notice: 'Member was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @tournament = Tournament.find(params[:tournament_id])
    @ligue = Ligue.find(params[:ligue_id])


    @member.destroy
    respond_to do |format|
      format.html { redirect_to edit_tournament_ligue_url(@tournament.id, @ligue.id), notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    def set_member
      @member = Member.find(params[:id])
    end

    def member_params
      params.require(:member).permit(:pwin, :ploose, :user_id, :ligue_id, :status, :score, :scoreday)
    end
end
