class Public::AddressesController < ApplicationController
  def create
  end

  def index
    @addresses = Address.all
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
  end

  def destroy
  end
end
