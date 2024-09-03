class LineBotController < ApplicationController
  skip_before_action :require_login
  require 'line/bot'
  protect_from_forgery except: [:callback]
  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do
        'Bad Request'
      end
    end
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
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_id = Rails.application.credentials.dig(:linebot, :channel_id)
      config.channel_secret = Rails.application.credentials.dig(:linebot, :channel_secret)
      config.channel_token = Rails.application.credentials.dig(:linebot, :channel_token)
    end
  end
end
