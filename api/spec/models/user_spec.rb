# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it '正常テスト' do
    @user = User.new(
      name: 'test',
      email: 'test1@sample.com'
    )
    expect(@user).to be_valid
  end
end
