class ReportsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_report, only: [:destroy]
  before_action :set_item, only: [:create]
  before_action :set_reported_user, only: [:create]
  before_action :set_reportable, only: [:create]

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)
    @report.user = current_user
    @report.reportable = @reportable
    respond_to do |format|
      if @report.save
        format.html {redirect_to @reportable, notice: 'Report was successfully created.'}
      else
        format.html {redirect_to root_path, error: 'Fail to create report'}
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @reportable = @report.reportable
    @report.destroy
    respond_to do |format|
      format.html {redirect_to @reportable, notice: 'Report was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  def set_item
    if params[:type] == "BidItem"
      @item = BidItem.find(params[:bid_item_id])
    elsif params[:type] == "NonBidItem"
      @item = NonBidItem.find(params[:non_bid_item_id])
    elsif params[:item_id]
      @item = Item.find(params[:item_id])
    else
      @item = nil
    end
  end

  def set_reported_user
    if params[:user_id]
      @reported_user = User.find(params[:user_id])
    else
      @reported_user = nil
    end

  end

  # Use callbacks to share common setup or constraints between actions.
  def set_report
    @report = Report.find(params[:id])
    @reportable = @report.reportable
  end

  def set_reportable
    if !@item.nil?
      @reportable = @item
    else
      @reportable = @reported_user
    end
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def report_params
    params.require(:report).permit(:reportable_type, :reportable_id, :reason)
  end
end
