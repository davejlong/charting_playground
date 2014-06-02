module SeeClickFix
  class SeeClickFix
    include HTTParty

    base_uri 'test.seeclickfix.com'

    def issues(options={})
      self.class.get('/api/v2/issues', options)
    end
  end
end
