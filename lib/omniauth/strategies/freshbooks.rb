require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Freshbooks < OmniAuth::Strategies::OAuth2
      option :name, 'freshbooks'

      option :client_options, {
          site: 'https://freshlook.io',
          authorize_url: 'https://my.freshbooks.com/service/auth/integrations/sign_in',
          token_url: 'https://api.freshbooks.com/auth/oauth/token'
      }
    end
  end
end
