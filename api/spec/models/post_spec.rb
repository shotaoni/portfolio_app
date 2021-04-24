# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'バリデーションテスト' do
    context '投稿作成時' do
      subject(:post) { create(:post) }

      it { is_expected.to be_valid }
      it { is_expected.to validate_length_of(:point) }
    end
  end

  describe 'アソシエーションテスト' do
    subject(:post) { create(:post) }

    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:links) }
    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:notifications) }
  end
end
