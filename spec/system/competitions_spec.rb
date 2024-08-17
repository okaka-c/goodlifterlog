require 'rails_helper'

RSpec.describe "Competitions", type: :system do
  let(:user) { create(:user) }

  before do
    driven_by(:rack_test)
  end

  describe 'ログインができるかどうかテスト' do
    context 'LINEログインをクリック' do
      it 'ログイン処理が成功する' do
        login(user)
        expect(page).to have_content 'LINEログインしました'
        expect(current_path).to eq competitions_path
      end
    end
  end

  # describe 'ログイン前' do
  # end

  # describe 'ログイン後' do
  #   before { login(user) }
  # end
end
