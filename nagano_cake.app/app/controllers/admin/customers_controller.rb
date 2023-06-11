class Admin::CustomersController < ApplicationController
  def index

  end

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

end
