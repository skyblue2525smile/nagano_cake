class ApplicationController < ActionController::Base
  private

  def after_sign_out_path_for(resource)
    if resource== :admin
      new_admin_session_path
    else
      root_path
    end
  end
end
