RSpec.describe OmniAuth::Strategies::MailruOauth2 do
  let(:server_userinfo) do
    {
      'nickname' =>  'Andrew Shalaev',
      'client_id' =>  123,
      'image' =>  'https://filin.mail.ru/foobar',
      'first_name' =>  'Andrew',
      'email' =>  'isqad88@gmail.com',
      'locate' =>  'ru_RU',
      'name' =>  'Andrew Shalaev',
      'last_name' =>  'Shalaev',
      'birthday' =>  '09.11.1988',
      'gender' =>  'm'
    }
  end
  let(:request) { double('Request', params: {}, cookies: {}, env: {}) }
  let(:app) do
    lambda do
      [200, {}, ['Hello.']]
    end
  end

  subject do
    described_class.new(app, 'appid', 'secret', @options || {}).tap do |strategy|
      allow(strategy).to receive(:request) { request }
    end
  end

  before { OmniAuth.config.test_mode = true }

  after { OmniAuth.config.test_mode = false }

  describe 'client options' do
    it do
      expect(subject.client.site).to eq 'https://oauth.mail.ru'
      expect(subject.client.authorize_url).to eq 'https://oauth.mail.ru/login'
      expect(subject.client.token_url).to eq 'https://oauth.mail.ru/token'
    end
  end

  describe '#authorize_params' do
    it do
      expect(subject.authorize_params).to include(scope: described_class::DEFAULT_SCOPE)
      expect(subject.authorize_params).to be_has_key(:state)
    end
  end

  describe 'userinfo' do
    let(:expected_userinfo) do
      {
        nickname: 'Andrew Shalaev',
        client_id: 123,
        image: 'https://filin.mail.ru/foobar',
        first_name: 'Andrew',
        email: 'isqad88@gmail.com',
        locate: 'ru_RU',
        name: 'Andrew Shalaev',
        last_name: 'Shalaev',
        birthday: '09.11.1988',
        gender: 'm'
      }
    end

    before { allow(subject).to receive(:raw_info).and_return(server_userinfo) }

    it { expect(subject.info).to include(expected_userinfo) }
  end

  describe 'uid' do
    before { allow(subject).to receive(:raw_info).and_return(server_userinfo) }

    it { expect(subject.uid).to eq('isqad88@gmail.com') }
  end
end
