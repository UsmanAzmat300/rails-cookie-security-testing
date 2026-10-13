# Rails.application.config.session_store :cookie_store,
#   key: '_session_before_app_session',
#   secure: false,
#   httponly: false,
#   same_site: nil
#   # No same_site set — deliberately omitted to construct the weak baseline
#   # No expire_after set — session does not reliably expire



Rails.application.config.session_store :cookie_store,
  key: '_session_before_app_session',
  secure: true,
  httponly: true,
  same_site: :lax,
  expire_after: 30.minutes
