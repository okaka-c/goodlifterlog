# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Competition, type: :model do
  describe 'バリデーションチェック', :aggregate_failures do
    context '全てのフィールドが有効な場合' do
      it '有効であること' do
        competition = build(:competition)
        expect(competition).to be_valid
        expect(competition.errors).to be_empty
      end
    end

    context '大会名が空白のとき' do
      it '無効であること' do
        competition = build(:competition, name: nil)
        expect(competition).to be_invalid
        expect(competition.errors[:name]).to include('を入力してください')
      end
    end

    context '大会名が225文字以上のとき' do
      it '無効であること' do
        competition = build(:competition)
        competition.name = 'a' * 256
        expect(competition).to be_invalid
        expect(competition.errors[:name]).to include('は255文字以内で入力してください')
      end
    end

    context '施設名が225文字以上のとき' do
      it '無効であること' do
        competition = build(:competition)
        competition.venue = 'a' * 256
        expect(competition).to be_invalid
        expect(competition.errors[:venue]).to include('は255文字以内で入力してください')
      end
    end

    context '開催日が空白のとき' do
      it '無効であること' do
        competition = build(:competition, date: nil)
        expect(competition).to be_invalid
        expect(competition.errors[:date]).to include('を入力してください')
      end
    end

    context '大会種別が空白のとき' do
      it '無効であること' do
        competition = build(:competition, competition_type: nil)
        expect(competition).to be_invalid
        expect(competition.errors[:competition_type]).to include('を入力してください')
      end
    end

    context 'ギア種別が空白のとき' do
      it '無効であること' do
        competition = build(:competition, gearcategory_type: nil)
        expect(competition).to be_invalid
        expect(competition.errors[:gearcategory_type]).to include('を入力してください')
      end
    end

    context '競技種別が空白のとき' do
      it '無効であること' do
        competition = build(:competition, category: nil)
        expect(competition).to be_invalid
        expect(competition.errors[:category]).to include('を入力してください')
      end
    end

    context '年齢区分が未選択のとき' do
      it '無効であること' do
        competition = build(:competition, age_group: nil)
        expect(competition).to be_invalid
        expect(competition.errors[:age_group]).to include('を入力してください')
      end
    end

    context '階級区分が未選択のとき' do
      it '無効であること' do
        competition = build(:competition, weight_class: nil)
        expect(competition).to be_invalid
        expect(competition.errors[:weight_class]).to include('を入力してください')
      end
    end
  end
end
