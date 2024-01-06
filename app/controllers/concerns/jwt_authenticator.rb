module JwtAuthenticator
  require "jwt"

  SECRET_KEY_BASE = Rails.application.credentials.secret_key_base

  def jwt_authenticate
    render json: { error: "認証情報が不足しています。" }, status: :unauthorized if request.headers["Authorization"].blank?
    encoded_token = request.headers["Authorization"].split("Bearer ").last
    payload = decode(encoded_token).transform_keys(&:to_sym)
    @user = User.find_by(id: payload[:user_id])
    render json: { error: "認証できません。" }, status: :unauthorized if @user.blank?
    @user
  end

  # 暗号化処理
  def encode(user_id)
    expires_in = 1.month.from_now.to_i
    preload = { user_id: user_id, exp: expires_in }
    JWT.encode(preload, SECRET_KEY_BASE, 'HS256')
  end

  # 復号化処理
  def decode(encoded_token)
    decoded_dwt = JWT.decode(encoded_token, SECRET_KEY_BASE, true, algorithm: 'HS256')
    decoded_dwt.first
  end
end
