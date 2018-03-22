require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Freshbooks < OmniAuth::Strategies::OAuth2
      option :name, 'freshbooks'

      option :client_options, {
        site: 'https://freshbooks.com',
        authorize_url: 'https://my.freshbooks.com/service/auth/oauth/authorize',
        token_url: 'https://api.freshbooks.com/auth/oauth/token'
      }

      option :token_params, {
        headers: { 'Api-Version' => 'alpha' }
      }

      def callback_url(include_query_string = true)
        url = full_host + script_name + callback_path

        # Optional inclusion of query_string ensure the access token request redirect_uri is an exact match to the
        # authorized redirect URI defined in FreshBooks
        url += query_string if include_query_string

        # Ensure valid request for localhost because FreshBooks doesn't authorize non ssl callbacks.
        # The ssl response can then be altered from https:// to http:// manually for the purpose of testing.
        # This is limitation is noted in "Redirect URI Limitations" section of their documentation:
        # https://www.freshbooks.com/api/authentication
        url.gsub('http://localhost', 'https://localhost')
      end

      def build_access_token
        verifier = request.params["code"]
        params = { redirect_uri: callback_url(false)}.merge(token_params.to_hash( symbolize_keys: true))
        client.auth_code.get_token(verifier, params, deep_symbolize(options.auth_token_params))
      end
    end
  end
end
