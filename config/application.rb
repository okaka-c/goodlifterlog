require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0


    # デフォルトのlocaleを日本語(:ja)にする
    config.i18n.default_locale = :ja
    # アプリケーションでの利用を許可するロケールのリストを渡す
    config.i18n.available_locales = %i[ja en]
    # I18nライブラリに訳文の探索場所を指示する
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    # バリデーションエラー時に、divタグのfield_with_errorsが挿入されないように設定
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }
  end
end
