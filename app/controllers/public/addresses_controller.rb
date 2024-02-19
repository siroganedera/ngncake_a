class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  
  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to request.referer
    else
      @address = Address.all
      render :index
    end
    
  end

  def index
    @address = Address.new
    @addresses = Address.all
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else
      render edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    @addresses = current_customer.address
    redirect_to addresses_path
  end
  
  private
  
  def address_params
    params.require(:address).permit(:name, :postal_code, :address, :customer_id)
  end
end
