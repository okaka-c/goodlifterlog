require 'rails_helper'

RSpec.describe "Competitions", type: :system do
  let(:user) { create(:user) }
  let(:competition) { create(:competition, user: user) }
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

  describe '大会情報のCRUD機能' do
    describe '大会情報一覧' do
      context 'ログインしていない場合' do
        it 'ログイン前トップページにリダイレクトされること' do
          visit '/competitions'
          expect(current_path).to eq(root_path), 'ログイン前トップページにリダイレクトされていません'
          expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
        end
      end

      context 'ログインしている場合' do
        it '正しいタイトルが表示されていること' do
          # titleタグの中身を検証
        end
        context '大会情報が1件もない場合' do
          it '何もない旨のメッセージが表示されること' do
          end
        end
        context '大会情報がある場合' do
          it '大会情報の一覧が表示されること' do
          end
        end
      end
    end

    describe '大会情報 新規登録ページ' do
      context 'ログインしていない場合' do
        it 'ログイン前トップページにリダイレクトされること' do
          visit '/competitions/new'
          expect(current_path).to eq(root_path), 'ログイン前トップページにリダイレクトされていません'
          expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
        end
      end

      context 'ログインしている場合' do
        it '正しいタイトルが表示されていること' do
          # titleタグの中身を検証
        end

        it '大会情報が作成できること' do
        end

        it '大会情報の作成に失敗すること' do
        end
      end
    end

    describe '大会情報 詳細ページ' do
      context 'ログインしていない場合' do
        it 'ログイン前トップページにリダイレクトされること' do
          visit competition_path(competition)
          expect(current_path).to eq(root_path), 'ログイン前トップページにリダイレクトされていません'
          expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
        end
      end

      context 'ログインしている場合' do
        it '大会情報の詳細が表示されること' do
        end

        it '正しいタイトルが表示されていること' do
        end
      end
    end

    describe '大会情報 更新ページ' do
      context 'ログインしていない場合' do
        it 'ログイン前トップページにリダイレクトされること' do
          visit edit_competition_path(competition)
          expect(current_path).to eq(root_path), 'ログイン前トップページにリダイレクトされていません'
          expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
        end
      end

      context 'ログインしている場合' do
        it '大会情報が更新できること' do
        end

        it '大会情報の更新に失敗すること' do
        end
      end
    end

    describe '大会情報 削除ページ' do
      context 'ログインしている場合' do
        it '大会情報が削除できること' do
        end
      end
    end
  end
end
