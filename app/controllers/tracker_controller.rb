class TrackerController < ApplicationController
  def create
    @order = Order.find_for_tracking(params[:order_number], params[:zipcode])
    if @order
      session[:tracked_order_id] = @order.try(:id)
      redirect_to tracker_url
    else
      flash[:error] = I18n.t('orders_tracker.couldnt_find_order')
      redirect_to new_tracker_url
    end
  end

  def show
    @order = Order.find_by_id(session[:tracked_order_id])
    redirect_to new_tracker_url and return if @order.nil?
    render :template => "orders/show"
  end

  def destroy
    session[:tracked_order_id] = nil
    redirect_to root_url
  end
end
