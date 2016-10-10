require File.expand_path('../../test_helper', __FILE__)

class RedmineTelegramConnectionsControllerTest < ActionController::TestCase
  fixtures :users, :email_addresses, :roles, :auth_sources

  setup do
    @user = User.find(2)
    @telegram_account = Redmine2FA::TelegramAccount.create(telegram_id: 123)
  end

  context 'connect with valid data' do
    setup do
      post :create,
           user_id: 2, user_email: @user.mail,
           telegram_id: 123, token: @telegram_account.token
    end

    should 'set telegram account to user' do
      assert_equal @telegram_account, @user.telegram_account
    end

    should 'set telegram auth source to user' do
      @user.reload
      assert_equal auth_sources(:telegram), @user.auth_source
    end
  end
end
