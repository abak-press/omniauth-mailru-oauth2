require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class MailruOauth2 < OmniAuth::Strategies::OAuth2
      DEFAULT_SCOPE = 'userinfo'.freeze

      option :name, 'mailru_oauth2'

      option :client_options, {
        site: 'https://oauth.mail.ru',
        authorize_url: '/login',
        token_url: '/token'
      }

      def authorize_params
        super.tap do |params|
          params[:scope] = params[:scope] || DEFAULT_SCOPE
        end
      end

      uid do
        raw_info['email']
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      info do
        {
          email: raw_info['email'],
          image: raw_info['image'],
          name: raw_info['name'],
          nickname: raw_info['nickname'],
          first_name: raw_info['first_name'],
          last_name: raw_info['last_name'],
          birthday: raw_info['birthday'],
          gender: raw_info['gender'],
          locate: raw_info['locate'],
          client_id: raw_info['client_id']
        }
      end

      def raw_info
        @raw_info ||= access_token.get("https://oauth.mail.ru/userinfo?access_token=#{access_token.token}").parsed
      end

      private

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end
