RSpec.configure do |config|
  config.before :each do
    stub_request(:get, /test.seeclickfix.com/)
      .to_return(status: 200, body: 'stubbed', headers: {
        'content-type' => 'application/json'
      })
  end
end
