# PowerLifter's Log
## サービスURL： https://www.powerlifterslog.com/
<a href="https://gyazo.com/16d30648859d60b9030f10713b02338d">
  <img src="https://i.gyazo.com/16d30648859d60b9030f10713b02338d.png" alt="Image from Gyazo" style="width: 80%; height: auto;"/>
</a>

### ■サービス概要
このサービスは、パワーリフティング大会やシングルベンチプレス大会の成績を登録・管理できるツールです。
パワーリフティングは、スクワット、ベンチプレス、デッドリフトの3種目の合計挙上重量で順位を決定する競技です。
シングルベンチプレス大会は、ベンチプレス種目のみで競われ、挙上重量によって順位が決まります。
本サービスでは、ユーザーが大会ごとの成績を登録することで、過去の大会と比較してどれだけ記録が伸びたかを自動で算出できます。また、成績をグラフ化して、成長の推移を視覚的に確認することができます。これにより、競技へのモチベーション向上をサポートします。

### ◾️使い方イメージ
| トップページ | 出場済大会情報一覧 |
|:-----------:|:------------:|
| <a href="https://gyazo.com/ad659d1985039cd461d89c245cf6de58"><img src="https://i.gyazo.com/ad659d1985039cd461d89c245cf6de58.gif" alt="Image from Gyazo" width="364" height="200"/></a> | <a href="https://gyazo.com/df97b635eea3028307f0bf054f02240b"><img src="https://i.gyazo.com/df97b635eea3028307f0bf054f02240b.png" alt="Image from Gyazo" width="364" height="200"/></a> |
| LINEログインで会員登録・ログインができます。 | ユーザーが登録した出場済大会が一覧で表示されます。 |

</br>

| 大会情報の登録| 試技結果の登録 |
|:-----------:|:------------:|
| <a href="https://gyazo.com/d24193c2e20d4f59727456c2e7bc10c9"><img src="https://i.gyazo.com/d24193c2e20d4f59727456c2e7bc10c9.gif" alt="Image from Gyazo" width="364" height="200"/></a> | <a href="https://gyazo.com/b22f3b8bcc4b2e6783fa8194b2963a09"><img src="https://i.gyazo.com/b22f3b8bcc4b2e6783fa8194b2963a09.gif" alt="Image from Gyazo" width="364" height="200"/></a> |
| 大会情報の登録画面です。 | 大会の試技結果の入力画面です。 |

</br>

| 大会情報詳細ページ | 合計重量・IPFGLポイント自動計算 |
|:-----------:|:------------:|
| <a href="https://gyazo.com/5fdc98d3068a058eb9126480cffb9cfb"><img src="https://i.gyazo.com/5fdc98d3068a058eb9126480cffb9cfb.gif" alt="Image from Gyazo" width="364" height="200"/></a> | <a href="https://gyazo.com/5d317882f70d3d0398fe70161afefb6b"><img src="https://i.gyazo.com/5d317882f70d3d0398fe70161afefb6b.png" alt="Image from Gyazo" width="364" height="200"/></a> |
| 登録した大会情報の詳細が確認できます。 | 挙上重量の合計値とIPF GL ポイントを自動計算します。</br> 前回大会比を自動計算します。 |

</br>

| 成績グラフ化機能 |
|:-----------:|
| <a href="https://gyazo.com/8b9abf5db8a267d8e280317609cb1ea8"><img src="https://i.gyazo.com/8b9abf5db8a267d8e280317609cb1ea8.png" alt="Image from Gyazo" width="364" height="200"/></a> |
| 成績をグラフ化して、成長の推移を視覚的に確認することができます。 |


| カテゴリ | 技術 |
| --- | --- |
| 開発環境 | Docker |
| フロントエンド | Bootstrap または TailwindCSS, Hotwire |
| バックエンド | Ruby 3.2.2 / Ruby on Rails 7系 |
| データベース | PostgreSQL,  |
| インフラ | Render |
| Web API | LINE Messaging API |
| その他 | AWS S3 (動画投稿機能追加時に使用検討） |

### ■ 画面遷移図
[Figma: 画面遷移図](https://www.figma.com/file/pGxlFmkWvjxv384P6Ymi9x/Good-Lifter-log?type=design&node-id=0%3A1&mode=design&t=7WateIMFCpHj8mR9-1)

### ■ ER図

```mermaid

 
erDiagram
    users ||--|| profiles : "1対1"
    users ||--o{ competitions : "1対多"
    competitions ||--|| competition_records : "1対1"
    users ||--o{ template_names : "1対多"
    template_names ||--|| template_categories : "1対1"
    template_categories ||--o{ template_items : "1対多"
    users ||--o{ itemlist_names : "1対多"
    itemlist_names ||--o{ competitions : "1対多"
    itemlist_names ||--o{ itemlist_categories : "1対多"
    itemlist_categories ||--o{ itemlist_items : "1対多"
    
    users {
        int id PK "ID"
        string email "メールアドレス"
        string crypted_password "暗号化されたパスワード"
        string salt "ソルト"
        datetime created_at "作成日時"
        datetime updated_at "更新日時"
    }

    profiles {
        int id PK "ID"
        int user_id FK "ユーザーID"
        string name "名前"
        int gender "性別"
        datetime created_at "作成日時"
        datetime updated_at "更新日時"
    }

    competitions {
        int id PK "ID"
        int user_id FK "ユーザーID"
        int itemlist_name_id FK "アイテムリスト名ID"
        string name "大会名"
        string location "開催場所名"
        date date "開催日"
        int type "大会種別(公式/非公式)"
        int gearcategory_type "競技種別(クラシック/エクイップ)"
        int category "競技種別(3種か1種か)"
        int age_group "年齢別区分"
        int weight_class "体重別区分"
        int participation_status "出場予定か済みかステータス"
        datetime created_at "作成日時"
        datetime updated_at "更新日時"
    }

   competition_records {
        int id PK "ID"
        int competition_id FK "大会情報ID"
        float weight "検量体重"
        float squat_first_attempt "スクワット第1試技"
        float squat_second_attempt "スクワット第2試技"
        float squat_third_attempt "スクワット第3試技"
        float benchpress_first_attempt "ベンチプレス第1試技"
        float benchpress_second_attempt "ベンチプレス第2試技"
        float benchpress_third_attempt "ベンチプレス第3試技"
        float deadlift_first_attempt "デッドリフト第1試技"
        float deadlift_second_attempt "デッドリフト第2試技"
        float deadlift_third_attempt "デッドリフト第3試技"
        int squat_first_attempt_result "スクワット第1試技判定結果"
        int squat_second_attempt_result "スクワット第2試技判定結果"
        int squat_third_attempt_result "スクワット第3試技判定結果"
        int benchpress_first_attempt_result "ベンチプレス第1試技判定結果"
        int benchpress_second_attempt_result "ベンチプレス第2試技判定結果"
        int benchpress_third_attempt_result "ベンチプレス第3試技判定結果"
        int deadlift_first_attempt_result "デッドリフト第1試技判定結果"
        int deadlift_second_attempt_result "デッドリフト第2試技判定結果"
        int deadlift_third_attempt_result "デッドリフト第3試技判定結果"
        text comment "反省点コメント"
        datetime created_at "作成日時"
        datetime updated_at "更新日時"
    }

    template_names {
        int id PK "ID"
        int user_id FK "ユーザーID"
        string name "テンプレート名"
        datetime created_at "作成日時"
        datetime updated_at "更新日時"
    }

    template_categories {
        int id PK "ID"
        int template_name_id FK "テンプレートID"
        string name "テンプレートカテゴリ名"
        datetime created_at "作成日時"
        datetime updated_at "更新日時"
    }

    template_items {
        int id PK "ID"
        int template_category_id FK "テンプレートカテゴリID"
        string name "テンプレートカテゴリ用アイテム名"
        datetime created_at "作成日時"
        datetime updated_at "更新日時"
    }

    itemlist_names {
        int id PK "ID"
        int user_id FK "ユーザーID"
        string name "持ち物リスト名"
        datetime created_at "作成日時"
        datetime updated_at "更新日時"
    }

    itemlist_categories {
        int id PK "ID"
        int itemlist_name_id FK "アイテムリスト名ID"
        string name "アイテムリストカテゴリ名"
        datetime created_at "作成日時"
        datetime updated_at "更新日時"
    }

    itemlist_items {
        int id PK "ID"
        int itemlist_category_id FK "アイテムリストカテゴリID"
        string name "アイテムリストカテゴリ用アイテム名"
        datetime created_at "作成日時"
        datetime updated_at "更新日時"
    }

```