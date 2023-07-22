class Public::AddressesController < ApplicationController
  def new
    @address = Address.new
  end
  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to address_index_path
    else
      @addresses = current_customer.addresses
      render 'index'
    end
  end

  def index
    @addresses = current_customer.addresses
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to address_index_path
    else
      render 'edit'
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    @address = current_customer.addresses
    redirect_to address_index_path
  end

  private
  def address_params
    params.require(:address).permit(:address_name, :address, :postal_code)
  end

end
