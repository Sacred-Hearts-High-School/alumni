class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  before_action :login_required, except: [:new, :create, :success, :search]
  before_action :login_required, :admin_required, except: [:new, :create, :success, :search]
  
  skip_before_action :verify_authenticity_token, :only=>[:search]

  # GET /members
  # GET /members.json
  def index
    @members = Member.page params[:page]
  end

  def search
    @keyword = params[:name]
    pid = params[:pid]
    birthday = params[:birthday]
 
    if (not pid.nil?) and pid.length==10  # 如果身分證字號不是 10 個字元，那就不正確
      pid = pid.upcase  # 身分證字號自動轉成大寫
    else
      pid = nil
    end       
    
    if @keyword
      if pid
        @member1 = Member.find_by(:name=>@keyword, :birthday=>params[:birthday], :pid=>pid)
        @member1 = nil if @member1 and @member1.pid.length!=10 # 如果身分證字號不是 10 個字元，那就不正確
      end
      
      @member2 = Member.find_by(:name=>@keyword, :birthday=>params[:birthday])      
      @members = Member.where(:name=>@keyword)
      @members = nil if @members and @members.count == 0
    else
      @members = nil
      @member1 = nil
      @member2 = nil
    end


    @result = 0

    if @keyword
      if @member1
        @result = 1
      elsif @member2
        @result = 2
      elsif @members
        @result = 3
      else
        @result = 0
      end
    end

    # 如果是 API，只返回 json 格式。
    render plain: @result if request.post?

  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  def import
    Thread.new do
      begin
        Member.import(params[:file])
      rescue => e
        p e  # 連語法錯誤都捕捉了
      end
    end     

    redirect_to members_path, notice: "已經在背景進行匯入資料的工作，視系統狀況，約 10 秒左右可以完成。<br>在完成之前，請勿重複進行匯入動作！".html_safe
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:name, :pid, :birthday, :remark)
    end
end
