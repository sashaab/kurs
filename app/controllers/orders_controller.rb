class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def search
    @result = Order.search(params)
  end

  # GET /orders
  # GET /orders.json

  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    #@order.build_client
    @order.good_orders.build
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    if Order.count == 0
      @number_of_order = 1
    else
      @number_of_order = Order.last.order_number + 1
    end

    @order.order_number = @number_of_order
    tn = Time.now
    @order.order_date = Date.new(tn.year, tn.month, tn.day)

    arr = []
    @order.good_orders.each do |l|
      arr << l.good.title
    end
    arr.uniq!
    srrr=""
      for ccc in 0 ... arr.length
      srrr = srrr + "\n #{ccc+1}) #{arr[ccc]} \n"
      end
    @order.list_products=srrr
    cost = 0
    @order.good_orders.each do |l|
      cost += l.good.current_price * (l.digit.nil? ? 0 : l.digit)
    end
    @order.cost_goods = cost

    extra_cost = 0
    extra_cost = case @order.delivery_method
    when 'Самовывоз = бесплатно'
      0
    when "Почта России = 100 рублей"
      100
    when 'Курьером = 200 рублей'
      200
    end
	@order.total_cost = cost + extra_cost

    respond_to do |format|
      status = @order.save
      flag = true
      @order.good_orders.each do |l|
          if l.digit.nil? or (l.digit < l.good.minimum_quantity)
          l.errors.add(:digit, "Должно быть больше или равно #{l.good.minimum_quantity}")
          flag = false
        end
        if l.digit.nil? or (l.digit > l.good.quantity_in_stock)
          l.errors.add(:digit, "Должно быть меньше или равно #{l.good.quantity_in_stock}")
          flag = false
        end
      end
      if flag and status
        @order.good_orders.each do |l|
          p = Good.where(id: l.good_id).first
          p.quantity_in_stock -= l.digit
          p.save
        end
        format.html { redirect_to @order, notice: 'Заказ успешно добавлен' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    arr = []
    hash = order_params
    hash["good_orders_attributes"].each do |p|
      if p[1]["_destroy"] == "1"
        arr << p[1]["id"].to_i
        hash["good_orders_attributes"].delete(p[0])
      end
    end
    arr.each do |id|
      l = GoodOrder.where("id = ?", id).first
      l.good.quantity_in_stock += l.digit
      l.good.save
      l.destroy
    end

    tn = Time.now
    @order.order_date = Date.new(tn.year, tn.month, tn.day)

    arr = []
    @order.good_orders.each do |l|
      arr << l.good.title
    end
    arr.uniq!
    srrr=""
    for ccc in 0 ... arr.length
      srrr = srrr + "\n #{ccc+1}) #{arr[ccc]} \n"
    end
    @order.list_products=srrr
    cost = 0
    @order.good_orders.each do |l|
      cost += l.good.current_price * (l.digit.nil? ? 0 : l.digit)
    end
    @order.cost_goods = cost

    extra_cost = 0
    extra_cost = case @order.delivery_method
    when 'Самовывоз = бесплатно'
      0
    when "Почта России = 100 рублей"
      100
    when 'Курьером = 200 рублей'
      200
    end
    @order.total_cost = cost + 100  

    respond_to do |format|
      if @order.update(hash)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Товар успешно удален.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white good_order through.
    def order_params
      params.require(:order).permit(:order_number, :payment_method, :delivery_method, :list_products, :cost_goods, :total_cost, :order_date, :client_id,
      {client_attributes: [:id, :name, :phone, :address, :email]},
      {good_orders_attributes: [:_destroy, :id, :good_id, :digit]})
    end
end
