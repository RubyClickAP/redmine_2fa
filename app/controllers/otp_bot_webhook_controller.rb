# Telegram Bot Webhook handler
class OtpBotWebhookController < ActionController::Base
  unloadable

  before_filter :authorize

  def update
    logger = Logger.new(Rails.root.join('log/redmine_2fa', 'bot-update.log'))
    logger.debug params

    Redmine2FA::Telegram::BotService.new(params[:message]).call if params[:message].present?

    head :ok
  end

  private

  def authorize
    head 403 unless params[:token] && Redmine2FA.bot_token == params[:token]
  end
end
