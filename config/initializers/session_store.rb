# Be sure to restart your server when you modify this file.

Buffset::Application.config.session_store :cookie_store, :key => '_buffset_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Buffset::Application.config.session_store :active_record_store

# Be sure to restart your server when you modify this file.

Buffset::Application.config.session_store :cookie_store

Buffset::Application.config.session = {
  :key          => '_omniauthpure_session',     # name of cookie that stores the data
  :domain       => nil,                         # you can share between subdomains here: '.communityguides.eu'
  :expire_after => 1.month,                     # expire cookie
  :secure       => false,                       # fore https if true
  :httponly     => true,                        # a measure against XSS attacks, prevent client side scripts from accessing the cookie

  :secret      => '9dbb26f889648e6b0f53e04b295debfd739deee2b05697566ea795f9549bf624f640e58a8c5aaae12f86850a703e10b28a491eee0d16e615cca0cb06c941aa98'
}
