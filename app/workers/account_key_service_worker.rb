class AccountKeyServiceWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 5
  def perform(user_id)
    user = User.find(user_id)
    result = HTTParty.post("https://account-key-service.herokuapp.com/v1/account",
      :body => {
        :email => user.email,
       :key => user.key
      }.to_json,
      :headers => { 'Content-Type' => 'application/json' } )
    if result
      user.account_key = result["account_key"]
      user.save(validate: false)
    end
  end
end
