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

### ◾️サービスを作成した背景
私は5年間、パワーリフティング競技に取り組み、毎年大会に出場しています。
このサービスを作った背景には、**成績を記録する専用ツールが無い**という課題がありました。

私自身も含め、選手たちは大会結果をSNS、紙のノート、携帯のメモ帳などに記録しています。
しかし、過去の記録を振り返ったり、前回大会からどれくらい成績が増減したかどうか確認したい時に、
検索がしにくいと感じることが多々ありました。
また、今大会の成績と前大会の成績を比較し、
何kg上がったか、下がったかを毎回手動で計算して確認していたため、時間がかかっていました。

上記の課題から、大会の成績を管理し、簡単に比較できるツールがあれば便利だと考え、このツールを開発しました。

### ◾️ユーザー層について
パワーリフティング、シングルベンチプレスの競技者

### ◾️工夫したポイント
#### テーマカラーの選定理由のこだわり
競技用プレートで最も重い25kgプレートが赤色であることから、テーマカラーに赤色を採用しました。
選手たちはこのプレートを「赤盤」と呼び、赤盤を多くつけられることが強さの象徴となります。
**「ついに赤盤◯◯枚で◯◯kgを挙げた！」「次は赤盤◯◯枚を目指したい！」**といったように、
赤盤への思い入れが競技力向上へのモチベーションに繋がります。
そのため、赤色は選手たちの情熱を象徴するカラーとして最適だと考えました。

#### ユーザビリティ向上のため、試技結果の登録フォームをステップ入力フォーム化
<a href="https://gyazo.com/588d5b635d6d500027f11a71d3c12a80">
  <img src="https://i.gyazo.com/588d5b635d6d500027f11a71d3c12a80.gif" alt="Image from Gyazo" style="width: 55%; height: auto;"/>
</a>

試技結果の新規登録フォームを、ステップ入力フォームにしました。
試技結果の入力項目数は、最大20項目になります。最初は1ページにすべてまとめていましたが、
実際のユーザーの使用状況を考え、 実際にその状況下で使ってみたときに使いづらいことがわかりました。
解決策としてステップ入力フォームを実装し、以下のように5ページに分割することにしました。
1. 検量体重フォーム
2. スクワットフォーム
3. ベンチプレスフォーム
4. デッドリフトフォーム
5. コメント入力フォーム

- 各フォームごとに入力データのバリデーションを実行し、成功すれば次のフォームへ遷移します。
失敗した場合はユーザーに再入力を促します。
- 各フォームの段階ではデータベースに保存せず、バリデーションのみを行い、
最後のステップが完了した時点で全てのデータを一括してデータベースに保存します。

これにより、各ステップでデータの正確性を確認しながら、不要な中間データが保存されないようにしています。
これを実現するために、各ステップごとにコントローラとモデルを作成し実装しました。
結果的に入力ミスも減り、実際のユーザーには使いやすい、見やすいと言っていただけました。

### ■ 使用技術
| カテゴリ | 技術 |
| --- | --- |
| 開発環境 | Docker |
| フロントエンド |TailwindCSS, DaisyUI|
| バックエンド | Ruby 3.2.2 / Ruby on Rails 7系 |
| データベース | PostgreSQL |
| インフラ | Render |
| Web API | LINE Messaging API |
| 認証 | Sorcery, LINE認証 |
| CI | GitHub Actions (Rubocop, RSpec)|
| その他 | Chart.js, Rubocop, RSpec|

### ◾️インフラ構成図
<a href="https://gyazo.com/4500886a72bd5e243afa4c85df8f8d9a">
  <img src="https://i.gyazo.com/4500886a72bd5e243afa4c85df8f8d9a.png" alt="Image from Gyazo" style="width: 55%; height: auto;"/>
</a>

- GitHub Actions(CI)
GitHub Actionsを使って、CI環境で自動的にRubocopとRSpecを実行しています。main ブランチにコードがプッシュされた際やプルリクエストが送信された際に、このワークフローがトリガーされ、指定されたチェックが自動で行われます。
RSpecを用いることで、テストを通じてプログラムの動作を確認し、品質を向上させます。一方、Rubocopを使用することで、コードスタイルを統一し、コードの品質や可読性を保ちます。
このプロセスを継続的に実行することで、Webサービスの全体的な品質を常に高い状態に維持することができます。

### ■ 画面遷移図
[Figma: 画面遷移図](https://www.figma.com/file/pGxlFmkWvjxv384P6Ymi9x/Good-Lifter-log?type=design&node-id=0%3A1&mode=design&t=7WateIMFCpHj8mR9-1)

### ■ ER図

```mermaid
erDiagram
    users ||--|| profiles : "1対1"
    users ||--o{ competitions : "1対多"
    users ||--o{ authentications : "1対多"
    competitions ||--|| competition_records : "1対1"
    competition_records ||--|| competition_results : "1対1"

    users {
        int id PK "ID"
        string name "名前"
        string email "メールアドレス"
        string crypted_password "暗号化されたパスワード"
        string salt "ソルト"
        int role  "ユーザー権限"
        datetime created_at "作成日時"
        datetime updated_at "更新日時"
    }

    profiles {
        int id PK "ID"
        int user_id FK "ユーザーID"
        int gender "性別"
        date birthday "生年月日"
        datetime created_at "作成日時"
        datetime updated_at "更新日時"
    }

    authentications {
        int id PK "ID"
        int user_id FK "ユーザーID"
        string provider "外部プロバイダー"
        string uid "外部プロバイダーのユーザーID"
    }

    competitions {
        int id PK "ID"
        int user_id FK "ユーザーID"
        string name "大会名"
        string venue "開催場所名"
        date date "開催日"
        int competition_type "大会種別(公式/非公式)"
        int gearcategory_type "競技種別(クラシック/エクイップ)"
        int category "競技種別(パワーリフティングかシングルベンチプレスか)"
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

    competition_results {
        int id PK "ID"
        int competition_record_id FK "試技結果ID"
        float best_squat_weight "最大挙上スクワット重量"
        float best_benchpress_weight "最大挙上ベンチプレス重量"
        float best_deadlift_weight "最大挙上デッドリフト重量"
        float total_lifted_weight "合計重量"
        float ipf_points "IPFポイント"
    }
```

