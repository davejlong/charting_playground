RSpec.configure do |config|
  config.before :each do
    stub_request(:get, /test.seeclickfix.com/)
      .with(query: hash_including({'search' => 'wallingford'}))
      .to_return({
        status: 200,
        body: SeeClickFixture.fixture('see_click_fix_wallingford'),
        headers: {
          'content-type' => 'application/json'
        }
      })
    stub_request(:get, /test.seeclickfix.com/)
      .to_return({
        status: 200,
        body: SeeClickFixture.fixture('see_click_fix'),
        headers: {
          'content-type' => 'application/json'
        }
      })
  end
end

module SeeClickFixture
  def self.fixture(file)
    File.read Rails.root.join('spec', 'fixtures', "#{file}.json")
  end
end
