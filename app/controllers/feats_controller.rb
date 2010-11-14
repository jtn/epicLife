class FeatsController < ApplicationController
  before_filter :get_user

  # GET /feats
  # GET /feats.xml
  def index
    @date = params[:date].present? ? Date.parse(params[:date]) : Date.today
    beginning_of_day, end_of_day = @date.beginning_of_day, @date.end_of_day
    @feats = @person.feats.all(
      :include => :activity, 
      :conditions => ["activities.start_time > ? and activities.start_time < ?", beginning_of_day, end_of_day])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feats }
    end
  end

  # GET /feats/1
  # GET /feats/1.xml
  def show
    @feat = @person.feats.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @feat }
    end
  end

  # GET /feats/new
  # GET /feats/new.xml
  def new
    @feat = @person.feats.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feat }
    end
  end

  # GET /feats/1/edit
  def edit
    @feat = @person.feats.find(params[:id])
  end

  # POST /feats
  # POST /feats.xml
  def create
    @feat = @person.feats.new(params[:feat])

    respond_to do |format|
      if @feat.save
        format.html { redirect_to([@person, @feat], :notice => 'Feat was successfully created.') }
        format.xml  { render :xml => @feat, :status => :created, :location => @feat }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feat.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /feats/1
  # PUT /feats/1.xml
  def update
    @feat = @person.feats.find(params[:id])
    level_old = @person.level

    if params[:feat][:completed] == '1'
        @feat.complete
    else
        @feat.uncomplete
    end
    sign = params[:feat][:completed] == '1' ? '+': '-'
    
    has_leveled = @person.level > level_old

    respond_to do |format|
        format.json { render :json => {
            :xpGained => "#{sign}#{@feat.xp}",
            :xpTotal => @person.xp,
            :next_level_ratio => @person.next_level_ratio,
            :extra_life => @person.level_to_string,
            :has_leveled => has_leveled,
            :completed => @feat.completed,
            :streak => @feat.calculate_streak}}
    
    end

  end

  # DELETE /feats/1
  # DELETE /feats/1.xml
  def destroy
    @feat = @person.feats.find(params[:id])
    @feat.destroy

    respond_to do |format|
      format.html { redirect_to(person_feats_url(@person)) }
      format.xml  { head :ok }
    end
  end

  private
  def get_user
    @person = Person.find(params[:person_id]) unless params[:person_id].blank?
  end
end
