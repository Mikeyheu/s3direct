# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
S3direct::Application.config.secret_key_base = '2a47581bd4b2cee5b29ce04f90de1857830abf55c600def1bf610af9d8687043e2cc1d9523c01b722a51addea5d6efcd8787b6a6b16c000695751cccb158c370'
