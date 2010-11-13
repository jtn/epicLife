class FeatsController < ApplicationController
  before_filter :get_user

  # GET /feats
  # GET /feats.xml
  def index
    @feats = @person.feats.all(:include => :activity)

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

    respond_to do |format|
      if @feat.update_attributes(params[:feat])
        format.html { redirect_to([@person, @feat], :notice => 'Feat was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feat.errors, :status => :unprocessable_entity }
      end
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
