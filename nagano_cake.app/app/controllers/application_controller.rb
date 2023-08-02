class ApplicationController < ActionController::Base
  private

  def after_sign_in_path_for(resource)
    if resource== :admin
      admin_root_path
    else
      customer_path(current_customer)
    end
  end

  def after_sign_out_path_for(resource)
    if resource== :admin
      new_admin_session_path
    else
      root_path
    end
    #adminがログイン時、ログアウト後の遷移先はログイン画面になる
  end
end
