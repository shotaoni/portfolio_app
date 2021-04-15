# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションテスト' do
    context 'ユーザ作成時' do
      subject(:user) { create(:user) }
      it { is_expected.to be_valid }
      it { is_expected.to validate_presence_of(:uid) }
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_length_of(:name) }
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_length_of(:email) }
    end

    it 'uid, name, emailを設定すると成功' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'uid, name, emailが空だと失敗' do
      user = build(:user)
      user.uid = ''
      user.name = ''
      user.email = ''
      expect(user).to be_invalid
    end

    it 'nameが21文字以上だと失敗' do
      user = build(:user)
      user.name = 'a' * 21
      expect(user).to be_invalid
    end

    it 'email,uidの値がユニークだと成功' do
      user_1 = create(:user)
      user_2 = build(:user)
      expect(user_2).to be_valid
    end

    it 'emailがユニークでないと失敗' do
      user_1 = create(:user)
      user_2 = build(:user)
      user_2.email = user_1.email
      expect(user_2).to be_invalid
    end

    it 'uidがユニークでないと失敗' do
      user_1 = create(:user)
      user_2 = build(:user)
      user_2.uid = user_1.uid
      expect(user_2).to be_invalid
    end

    context 'Userモデル更新時のバリデーションテスト' do
      it 'prodileの文字数が255以下だと成功' do
        user = build(:user)
        user.profile = 'a' * 255
        expect(user).to be_valid
      end

      it 'prodileの文字数が256以上だと失敗' do
        user = build(:user)
        user.profile = 'a' * 256
        expect(user).to be_invalid
      end
    end
  end

  describe 'アソシエーションテスト' do
    subject(:user) { create(:user) }
    it { is_expected.to have_many(:posts) }
    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:active_relationships) }
    it { is_expected.to have_many(:passive_relationships) }
    it { is_expected.to have_many(:following) }
    it { is_expected.to have_many(:followers) }
    it { is_expected.to have_many(:liked_posts) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:active_notifications) }
    it { is_expected.to have_many(:passive_notifications) }
  end
end
