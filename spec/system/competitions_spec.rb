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

  describe '大会情報のCRUD機能'
    describe '大会情報一覧' do
      context 'ログインしていない場合' do
        it 'ログイン前トップページにリダイレクトされること' do
        end
      end
      context 'ログインしている場合' do
      end
    end
    describe '大会情報 新規登録ページ' do
      context 'ログインしていない場合' do
        it 'ログイン前トップページにリダイレクトされること' do
        end
      end
      context 'ログインしている場合' do
      end
    end
    describe '大会情報 詳細ページ' do
      context 'ログインしていない場合' do
        it 'ログイン前トップページにリダイレクトされること' do
        end
      end
      context 'ログインしている場合' do
      end
    end
    describe '大会情報 更新ページ' do
      context 'ログインしていない場合' do
        it 'ログイン前トップページにリダイレクトされること' do
        end
      end
      context 'ログインしている場合' do
      end
    end
    describe '大会情報 削除ページ' do
      context 'ログインしている場合' do
      end
    end
  end
end
