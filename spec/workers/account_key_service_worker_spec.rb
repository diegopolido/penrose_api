require 'rails_helper'
RSpec.describe AccountKeyServiceWorker, type: :worker do
  it "enqueues a Account Key worker" do
    user = create(:user)
    AccountKeyServiceWorker.perform_async(user.id)
    expect(AccountKeyServiceWorker).to have_enqueued_sidekiq_job(user.id)
   end
end
