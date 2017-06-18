class GoodOrdersController < ApplicationController
  before_action :set_good_order, only: [:show, :edit, :update, :destroy]

  # GET /good_orders
  # GET /good_orders.json
  def index
    @good_orders = GoodOrder.all
  end

  # GET /good_orders/1
  # GET /good_orders/1.json
  def show
  end

  # GET /good_orders/new
  def new
    @good_order = GoodOrder.new
  end

  # GET /good_orders/1/edit
  def edit
  end

  # POST /good_orders
  # POST /good_orders.json
  def create
    @good_order = GoodOrder.new(good_order_params)

    respond_to do |format|
      if @good_order.good.minimum_quantity > @good_order.digit
	    @good_order.errors.add(:digit, message: "Больше чем #{@good_order.good.minimum_quantity}")
	  end
      if @good_order.errors.empty? and @good_order.save
        format.html { redirect_to @good_order, notice: 'Лист успешно создан.' }
        format.json { render :show, status: :created, location: @good_order }
      else
        format.html { render :new }
        format.json { render json: @good_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /good_orders/1
  # PATCH/PUT /good_orders/1.json
  def update
    respond_to do |format|
      if @good_order.update(good_order_params)
        format.html { redirect_to @good_order, notice: 'Лист успешно обновлен.' }
        format.json { render :show, status: :ok, location: @good_order }
      else
        format.html { render :edit }
        format.json { render json: @good_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /good_orders/1
  # DELETE /good_orders/1.json
  def destroy
    @good_order.destroy
    respond_to do |format|
      format.html { redirect_to good_orders_url, notice: 'Лист успешно удален.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_good_order
      @good_order = GoodOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white good_order through.
    def good_order_params
      params.require(:good_order).permit(:good_id, :order_id, :digit)
    end
end
