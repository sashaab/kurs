class GoodsController < ApplicationController
  before_action :set_good, only: [:show, :edit, :update, :destroy]

  # GET /goods
  # GET /goods.json
  def index
    @goods = Good.all
  end

  # GET /goods/1
  # GET /goods/1.json
  def show
  end

  # GET /goods/new
  def new
    @good = Good.new
  end

  # GET /goods/1/edit
  def edit
  end

  # POST /goods
  # POST /goods.json
  def create
    @good = Good.new(good_params)

    respond_to do |format|
      if @good.save
        format.html { redirect_to @good, notice: 'Товар успешно создан.' }
        format.json { render :show, status: :created, location: @good }
      else
        format.html { render :new }
        format.json { render json: @good.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /goods/1
  # PATCH/PUT /goods/1.json
  def update
    respond_to do |format|
      if @good.update(good_params)
        format.html { redirect_to @good, notice: 'Товар успешно обновлен.' }
        format.json { render :show, status: :ok, location: @good }
      else
        format.html { render :edit }
        format.json { render json: @good.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goods/1
  # DELETE /goods/1.json
  def destroy
    begin
      @good.destroy
    rescue ActiveRecord::InvalidForeignKey
      flash[:danger] = "Товар связан с заказом"
      respond_to do |format|
        format.html { redirect_to goods_url}
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to goods_url, notice: 'Товар успешно удален' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_good
      @good = Good.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def good_params
      params.require(:good).permit(:title, :short_description, :full_description, :list_id_images, :base_price, :current_price, :quantity_in_stock, :article, :minimum_quantity)
    end
end
