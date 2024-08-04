require 'rails_helper'

RSpec.describe Competition, type: :model do
  describe 'バリデーションチェック' do
    context '全てのフィールドが有効な場合' do
      it '有効であること' do
      end
    end

    context 'ユーザーidが空白のとき' do
      it '無効であること' do
      end
    end

    context '大会名が空白のとき' do
      it '無効であること' do
      end
    end

    context '大会名が225文字以上のとき' do
      it '無効であること' do
      end
    end

    context '施設名が225文字以上のとき' do
      it '無効であること' do
      end
    end

    context '開催日が空白のとき' do
      it '無効であること' do
      end
    end

    context '大会種別が空白のとき' do
      it '無効であること' do
      end
    end

    context 'ギア種別が空白のとき' do
      it '無効であること' do
      end
    end

    context '競技種別が空白のとき' do
      it '無効であること' do
      end
    end

    context '年齢区分が未選択のとき' do
      it '無効であること' do
      end
    end

    context '階級区分が未選択のとき' do
      it '無効であること' do
      end
    end
  end
end