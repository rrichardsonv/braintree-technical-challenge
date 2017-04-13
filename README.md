# Braintree Technical Challenge

## Setup Instructions

1. Install bundler:

  ```sh
  gem install bundler
  ```

2. Bundle:

  ```sh
  bundle
  ```
3. Copy the contents of `apikeys.env` into a new file named `.env` and fill in your Braintree API credentials. Credentials can be found by navigating to Account > My User > View Authorizations in the Braintree Control Panel. Full instructions can be [found on Braintree's support site](https://articles.braintreepayments.com/control-panel/important-gateway-credentials#api-credentials).

4. Setup your database(you'll need postgresql. [if you don't already have it](https://www.moncefbelyamani.com/how-to-install-postgresql-on-a-mac-with-homebrew-and-lunchy/))

  ```sh
  rails db:create
  rails db:migrate
  rails db:seed
  ```


5. Start rails:

  ```sh
  rails server
  ```