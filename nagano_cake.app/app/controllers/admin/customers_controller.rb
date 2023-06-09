class Admin::CustomersController < ApplicationController
  def show
    @customer = current_user
  end

  def edit
    @customer = current_user
  end

  def update
    @customer = current_user
    if @customer.update
      redirect_to
    else
      render :edit
    end
  end

  def confirm

  end

  def withdrawal

  end

end
