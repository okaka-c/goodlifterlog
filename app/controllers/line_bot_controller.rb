class LineBotController < ApplicationController
  skip_before_action :require_login
  require 'line/bot'
  protect_from_forgery except: [:callback]
  def callback
    body = request.body.read
    # リクエストのボディ部分全体を文字列として読み取り、body変数にいれる
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    # request.envでHTTPリクエストの環境変数を格納したハッシュから'HTTP_X_LINE_SIGNATURE'
    # の値を取得。'HTTP_X_LINE_SIGNATURE'はリクエストの著名が含まれる
    # LINEから送信されたWebhookリクエストが正当なものであるかを検証
    # 著名が無効なものだったら、HTTPステータスコード400（Bad Request）を返す
    unless client.validate_signature(body, signature)
      error 400 do
        'Bad Request'
      end
    end
    # 有効なものだった場合以下の処理が続行される
    # イベントオブジェクトのリストを生成する
    # Line::Bot::Event::MessageType::Textの場合、
    # 受信したテキストメッセージの内容をそのまま
    # 返信メッセージとして構築します。
    events = client.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message = {
            type: 'text',
            text: event.message['text']
          }
          client.reply_message(event['replyToken'], message)
        end
      end
    end
    head :ok
  end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_id = Rails.application.credentials.dig(:linebot, :channel_id)
      config.channel_secret = Rails.application.credentials.dig(:linebot, :channel_secret)
      config.channel_token = Rails.application.credentials.dig(:linebot, :channel_token)
    end
  end
end
