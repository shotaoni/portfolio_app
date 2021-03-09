require 'rails_helper'

RSpec.describe "V1::Users", type: :request do
  
  describe 'User' do
    before(:each) do
      @status_code_ok = 200
    end
    it 'ユーザを表示' do
      @user = FactoryBot.create(:user)
      get '/v1/users/'
      @json = JSON.parse(response.body)
      expect(response.status).to eq(@status_code_ok)
    end
  end

end
