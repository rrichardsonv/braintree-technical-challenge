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
3. Copy the contents of `example.env` into a new file named `.env` and fill in your Braintree API credentials. Credentials can be found by navigating to Account > My User > View Authorizations in the Braintree Control Panel. Full instructions can be [found on our support site](https://articles.braintreepayments.com/control-panel/important-gateway-credentials#api-credentials).

4. Start rails:

  ```sh
  rails server
  ```

## Running Tests

### Running Unit Tests

Unit tests do not make API calls to Braintree and do not require Braintree credentials. You can run this project's unit tests by
calling `rake` on the command line.

### Running Integration Tests

Integration tests make API calls to Braintree and require that you set up your Braintree credentials. You can run this project's integration tests by adding your sandbox API credentials to `.env` and calling `rake spec:integration` on the command line.

### Running All Tests

You can run both unit and integrations tests by calling `rake spec` on the command line.

