# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Competitions', type: :system do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:competition) { create(:competition, user:) }

  describe 'ログインができるかどうかテスト', :aggregate_failures do
    context 'LINEログインをクリック' do
      it 'ログイン処理が成功する' do
        login(user)
        expect(page).to have_content 'LINEログインしました'
        expect(page).to have_current_path competitions_path, ignore_query: true
      end
    end
  end

  describe '大会情報のCRUD機能', :aggregate_failures do
    describe '大会情報一覧' do
      context 'ログインしていない場合' do
        it 'ログイン前トップページにリダイレクトされること' do
          visit '/competitions'
          expect(page).to have_current_path(root_path, ignore_query: true), 'ログイン前トップページにリダイレクトされていません'
          expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
        end
      end

      context 'ログインしている場合' do
        context '自分のアカウント' do
          before do
            login(user)
          end

          it '正しいタイトルが表示されていること' do
            expect(page).to have_current_path(competitions_path, ignore_query: true), '大会結果一覧ページにいません'
            expect(page).to have_title("大会結果一覧 | PowerLifter's Log"),
                            "大会一覧ページのタイトルに「大会結果一覧 | PowerLifter's Log」が含まれていません。"
          end

          context '大会情報が1件もない場合' do
            before do
              login(user)
            end

            it '何もない旨のメッセージが表示されること' do
              expect(page).to have_current_path(competitions_path, ignore_query: true), '大会結果一覧ページにいません'
              expect(page).to have_content('出場済の大会情報がありません'), '大会情報が一件もない場合、「出場済の大会情報がありません」というメッセージが表示されていません'
            end
          end

          context '大会情報がある場合' do
            context '自分の大会情報' do
              # before do
              #   login(user)
              # end

              it '大会情報の一覧が表示されること' do
                login(user)
                competition
                # visit '/competitions'
                expect(page).to have_content('テスト大会'), '大会名が表示されていません'
                expect(page).to have_content('公式大会'), '公式大会or非公式大会が表示されていません'
                expect(page).to have_content('パワーリフティング'), 'パワーリフティングorベンチプレスが表示されていません'
                expect(page).to have_content(Date.new(2024, 6, 30)), '開催日が表示されていません'
                expect(page).to have_content('女子47㎏級'), '階級区分が表示されていません'
                expect(page).to have_content('ノーギア'), 'ノーギアかフルギアか表示されていません'
              end
            end
          end
        end

        context '他人のアカウント' do
          context '他人の大会情報' do
            # before do
            #   login(another_user)
            # end

            it '他人のユーザーの大会情報の一覧が表示されていないこと' do
              competition
              login(another_user)
              visit '/competitions'
              expect(page).not_to have_content('テスト大会'), '他人のユーザーの大会情報の一覧が表示されています'
            end
          end
        end
      end
    end

    describe '大会情報 新規登録ページ' do
      context 'ログインしていない場合' do
        it 'ログイン前トップページにリダイレクトされること' do
          visit '/competitions/new'
          expect(page).to have_current_path(root_path, ignore_query: true), 'ログイン前トップページにリダイレクトされていません'
          expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
        end
      end

      context 'ログインしている場合' do
        before do
          login(user)
          click_on('記録する', match: :first)
        end

        it '正しいタイトルが表示されていること' do
          expect(page).to have_title("大会情報の登録 | PowerLifter's Log"), "タイトルに「大会情報の登録 | PowerLifter's Log」が含まれていません。"
        end

        it '大会情報が作成できること' do
          fill_in '大会名', with: 'テスト大会'
          fill_in '会場名', with: 'テスト設備'
          fill_in '開催日', with: Time.zone.today
          choose '公式大会'
          choose 'ノーギア'
          choose 'パワーリフティング'
          select '一般', from: '年齢別区分'
          select '女子47㎏級', from: '階級別区分'
          click_on '登録'
          expect(page).to have_content('大会情報を登録しました'), 'フラッシュメッセージ「大会情報を登録しました」が表示されていません'
          visit '/competitions'
          click_on '詳細'
          expect(page).to have_content('テスト大会'), '大会名が表示されていません'
          expect(page).to have_content('テスト設備'), '施設名が表示されていません'
          expect(page).to have_content('公式大会'), '公式大会or非公式大会が表示されていません'
          expect(page).to have_content('パワーリフティング'), 'パワーリフティングorベンチプレスが表示されていません'
          expect(page).to have_content(Time.zone.today), '開催日が表示されていません'
          expect(page).to have_content('女子47㎏級'), '階級区分が表示されていません'
          expect(page).to have_content('一般'), '年齢区分が表示されていません'
          expect(page).to have_content('ノーギア'), 'ノーギアかフルギアか表示されていません'
        end

        context '大会名が未入力の場合' do
          before do
            login(user)
            click_on('記録する', match: :first)
          end

          it '大会情報の作成に失敗すること' do
            fill_in '会場名', with: 'テスト設備'
            fill_in '開催日', with: '2023-10-01'
            choose '公式大会'
            choose 'ノーギア'
            choose 'パワーリフティング'
            select '一般', from: '年齢別区分'
            select '女子47㎏級', from: '階級別区分'
            click_on '登録'
            expect(page).to have_content('大会情報の登録に失敗しました'), 'フラッシュメッセージ「大会情報の登録に失敗しました」が表示されていません'
            expect(page).to have_content('大会名を入力してください'), 'エラーメッセージ「大会名を入力してください」が表示されていません'
          end
        end

        context '開催日が未入力の場合' do
          before do
            login(user)
            click_on('記録する', match: :first)
          end

          it '大会情報の作成に失敗すること' do
            fill_in '大会名', with: 'テスト大会'
            fill_in '会場名', with: 'テスト設備'
            choose '公式大会'
            choose 'ノーギア'
            choose 'パワーリフティング'
            select '一般', from: '年齢別区分'
            select '女子47㎏級', from: '階級別区分'
            click_on '登録'
            expect(page).to have_content('大会情報の登録に失敗しました'), 'フラッシュメッセージ「大会情報の登録に失敗しました」が表示されていません'
            expect(page).to have_content('開催日を入力してください'), 'エラーメッセージ「開催日を入力してください」が表示されていません'
          end
        end

        context '大会種別が未選択の場合' do
          before do
            login(user)
            click_on('記録する', match: :first)
          end

          it '大会情報の作成に失敗すること' do
            fill_in '大会名', with: 'テスト大会'
            fill_in '会場名', with: 'テスト設備'
            fill_in '開催日', with: '2023-10-01'
            choose 'ノーギア'
            choose 'パワーリフティング'
            select '一般', from: '年齢別区分'
            select '女子47㎏級', from: '階級別区分'
            click_on '登録'
            expect(page).to have_content('大会情報の登録に失敗しました'), 'フラッシュメッセージ「大会情報の登録に失敗しました」が表示されていません'
            expect(page).to have_content('大会種別を入力してください'), 'エラーメッセージ「大会種別を入力してください」が表示されていません'
          end
        end

        context 'ギア種別が未選択の場合' do
          before do
            login(user)
            click_on('記録する', match: :first)
          end

          it '大会情報の作成に失敗すること' do
            fill_in '大会名', with: 'テスト大会'
            fill_in '会場名', with: 'テスト設備'
            fill_in '開催日', with: '2023-10-01'
            choose '公式大会'
            choose 'パワーリフティング'
            select '一般', from: '年齢別区分'
            select '女子47㎏級', from: '階級別区分'
            click_on '登録'
            expect(page).to have_content('大会情報の登録に失敗しました'), 'フラッシュメッセージ「大会情報の登録に失敗しました」が表示されていません'
            expect(page).to have_content('ギア種別を入力してください'), 'エラーメッセージ「ギア種別を入力してください」が表示されていません'
          end
        end

        context '競技種別が未選択の場合' do
          before do
            login(user)
            click_on('記録する', match: :first)
          end

          it '大会情報の作成に失敗すること' do
            fill_in '大会名', with: 'テスト大会'
            fill_in '会場名', with: 'テスト設備'
            fill_in '開催日', with: '2023-10-01'
            choose '公式大会'
            choose 'ノーギア'
            select '一般', from: '年齢別区分'
            select '女子47㎏級', from: '階級別区分'
            click_on '登録'
            expect(page).to have_content('大会情報の登録に失敗しました'), 'フラッシュメッセージ「大会情報の登録に失敗しました」が表示されていません'
            expect(page).to have_content('競技種別を入力してください'), 'エラーメッセージ「競技種別を入力してください」が表示されていません'
          end
        end

        context '年齢別区分が未選択の場合' do
          before do
            login(user)
            click_on('記録する', match: :first)
          end

          it '大会情報の作成に失敗すること' do
            fill_in '大会名', with: 'テスト大会'
            fill_in '会場名', with: 'テスト設備'
            fill_in '開催日', with: '2023-10-01'
            choose '公式大会'
            choose 'ノーギア'
            choose 'パワーリフティング'
            select '女子47㎏級', from: '階級別区分'
            click_on '登録'
            expect(page).to have_content('大会情報の登録に失敗しました'), 'フラッシュメッセージ「大会情報の登録に失敗しました」が表示されていません'
            expect(page).to have_content('年齢別区分を入力してください'), 'エラーメッセージ「年齢別区分を入力してください」が表示されていません'
          end
        end

        context '階級別区分が未選択の場合' do
          before do
            login(user)
            click_on('記録する', match: :first)
          end

          it '大会情報の作成に失敗すること' do
            fill_in '大会名', with: 'テスト大会'
            fill_in '会場名', with: 'テスト設備'
            fill_in '開催日', with: '2023-10-01'
            choose '公式大会'
            choose 'ノーギア'
            choose 'パワーリフティング'
            select '一般', from: '年齢別区分'
            click_on '登録'
            expect(page).to have_content('大会情報の登録に失敗しました'), 'フラッシュメッセージ「大会情報の登録に失敗しました」が表示されていません'
            expect(page).to have_content('階級別区分を入力してください'), 'エラーメッセージ「階級別区分を入力してください」が表示されていません'
          end
        end
      end
    end

    describe '大会情報 詳細ページ' do
      context 'ログインしていない場合' do
        it 'ログイン前トップページにリダイレクトされること' do
          visit competition_path(competition)
          expect(page).to have_current_path(root_path, ignore_query: true), 'ログイン前トップページにリダイレクトされていません'
          expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
        end
      end

      context 'ログインしている場合' do
        # before do
        #   login(user)
        #   competition
        # end

        it '大会情報の詳細が表示されること' do
          login(user)
          competition
          click_on('詳細')
          expect(page).to have_current_path("/competitions/#{competition.id}", ignore_query: true),
                          '大会情報一覧の詳細ボタンから詳細画面へ遷移できません'
          expect(page).to have_content(competition.name), '大会名が表示されていません'
          expect(page).to have_content(competition.venue), '施設名が表示されていません'
          expect(page).to have_content(competition.competition_type_i18n), '公式大会or非公式大会が表示されていません'
          expect(page).to have_content(competition.category), 'パワーリフティングorベンチプレスが表示されていません'
          expect(page).to have_content(competition.date), '開催日が表示されていません'
          expect(page).to have_content(competition.weight_class), '階級区分が表示されていません'
          expect(page).to have_content(competition.age_group), '年齢区分が表示されていません'
          expect(page).to have_content(competition.gearcategory_type_i18n), 'ノーギアかフルギアか表示されていません'
        end

        it '正しいタイトルが表示されていること' do
          login(user)
          competition
          click_on('詳細')
          expect(page).to have_current_path("/competitions/#{competition.id}", ignore_query: true),
                          '大会情報一覧の詳細ボタンから詳細画面へ遷移できません'
          expect(page).to have_title("#{competition.name} | PowerLifter's Log"),
                          "タイトルに「#{competition.name} | PowerLifter's Log」が含まれていません。"
        end
      end
    end

    describe '大会情報 更新ページ' do
      context 'ログインしていない場合' do
        it 'ログイン前トップページにリダイレクトされること' do
          visit edit_competition_path(competition)
          expect(page).to have_current_path(root_path, ignore_query: true), 'ログイン前トップページにリダイレクトされていません'
          expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
        end
      end

      context 'ログインしている場合' do
        before do
          login(user)
          competition
          click_on('詳細')
          within "#competition-show-id-#{competition.id}" do
            click_on('編集')
          end
        end

        it '大会情報が更新できること' do
          expect(page).to have_current_path("/competitions/#{competition.id}/edit", ignore_query: true),
                          '編集ボタンから編集画面へ遷移できません'
          fill_in '大会名', with: 'テスト更新大会'
          fill_in '会場名', with: 'テスト更新設備'
          fill_in '開催日', with: '2023-10-01'
          choose '公式大会'
          choose 'ノーギア'
          choose 'パワーリフティング'
          select '一般', from: '年齢別区分'
          select '女子47㎏級', from: '階級別区分'
          click_on '更新'
          expect(page).to have_current_path("/competitions/#{competition.id}", ignore_query: true), '詳細画面へ遷移できません'
          expect(page).to have_content('大会情報を更新しました'), 'フラッシュメッセージ「大会情報を更新しました」が表示されていません'
        end

        it '大会情報の更新に失敗すること' do
          fill_in '大会名', with: ''
          fill_in '会場名', with: 'テスト更新設備'
          fill_in '開催日', with: '2023-10-01'
          choose '公式大会'
          choose 'ノーギア'
          choose 'パワーリフティング'
          select '一般', from: '年齢別区分'
          select '女子47㎏級', from: '階級別区分'
          click_on '更新'
          expect(page).to have_content('大会情報の更新に失敗しました'), 'フラッシュメッセージ「大会情報の更新に失敗しました」が表示されていません'
        end
      end
    end

    describe '大会情報 削除ページ' do
      context 'ログインしている場合' do
        before do
          login(user)
          competition
          click_on('詳細')
        end

        it '大会情報が削除できること' do
          page.accept_alert '削除しますか？' do
            click_on '削除'
          end
          expect(page).to have_content('大会情報を削除しました'), 'フラッシュメッセージ「大会情報を削除しました」が表示されていません'
          expect(page).to have_current_path('/competitions', ignore_query: true), '大会一覧ページへ遷移できません'
        end
      end
    end
  end
end
