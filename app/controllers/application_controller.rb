class ApplicationController < ActionController::Base
  # このコントローラが動作する前にログイン認証されていなければ、ログイン画面へリダイレクトする
  before_action :authenticate_user!, except: %i[top about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後は投稿一覧画面に遷移する
  def after_sign_in_path_for(_resource)
    posts_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[last_name first_name last_name_kana first_name_kana is_deleted])
  end
end
