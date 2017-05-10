develop_keys = Rails.env.production? ? [] : %w(
  DB_USER
  DB_PASSWORD
)

Figaro.require_keys(develop_keys)
