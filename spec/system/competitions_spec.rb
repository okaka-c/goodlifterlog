require 'rails_helper'

RSpec.describe "Competitions", type: :system do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
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
        context "自分のアカウント" do
          before do
            login(user)
          end

          it '正しいタイトルが表示されていること' do
            expect(current_path).to eq(competitions_path), "大会結果一覧ページにいません"
            expect(page).to have_title("大会結果一覧 | PowerLifter's Log"), "大会一覧ページのタイトルに「大会結果一覧 | PowerLifter's Log」が含まれていません。"
          end

          context '大会情報が1件もない場合' do
            it '何もない旨のメッセージが表示されること' do
              expect(current_path).to eq(competitions_path), "大会結果一覧ページにいません"
              expect(page).to have_content('出場済の大会情報がありません'), '大会情報が一件もない場合、「出場済の大会情報がありません」というメッセージが表示されていません'
            end
          end

          context '大会情報がある場合' do
            context '自分の大会情報' do
              it '大会情報の一覧が表示されること' do
                competition
                visit '/competitions'
                expect(page).to have_selector("#competition-id-#{competition.id}"), '大会結果が表示されていません'
                expect(page).to have_content(competition.name), '大会名が表示されていません'
                expect(page).to have_content(competition.competition_type_i18n), '公式大会or非公式大会が表示されていません'
                expect(page).to have_content(competition.category), 'パワーリフティングorベンチプレスが表示されていません'
                expect(page).to have_content(competition.date), '開催日が表示されていません'
                expect(page).to have_content(competition.weight_class), '階級区分が表示されていません'
                expect(page).to have_content(competition.gearcategory_type_i18n), 'ノーギアかフルギアか表示されていません'
              end
            end
          end
        end

        context "他人のアカウント" do
          context '他人の大会情報' do
            before do
              login(another_user)
            end

            it '他人のユーザーの大会情報の一覧が表示されていないこと' do
              competition
              visit '/competitions'
              expect(page).not_to have_selector("#competition-id-#{competition.id}"), '他人の大会情報が表示されています'
            end
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
