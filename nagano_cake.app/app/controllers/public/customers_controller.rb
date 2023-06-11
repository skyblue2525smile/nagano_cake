class Public::CustomersController < ApplicationController
  def show
   @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update
      redirect_to customer_registration_path
    else
      render :edit_customer_registration
    end
  end

  def confirm

  end

  def withdrawal

  end
end
