require 'spec_helper'

describe OmniAuth::Strategies::Freshbooks do
  subject do
    @subject ||= begin
      @options ||= {}
      args = ['client_id', 'client_secret', @options].compact
      OmniAuth::Strategies::Freshbooks.new(*args)
    end
  end

  context 'client options' do
    it 'should have correct name' do
      expect(subject.options.name).to eq('freshbooks')
    end

    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq('https://reshbooks.com')
    end

    it 'should have correct authorize url' do
      expect(subject.options.client_options.authorize_url).to eq('https://my.freshbooks.com/service/auth/oauth/authorize')
    end

    it 'should have correct access token url' do
      expect(subject.options.client_options.token_url).to eq('https://api.freshbooks.com/auth/oauth/token')
    end
  end
end
