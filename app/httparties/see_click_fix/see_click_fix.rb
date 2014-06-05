begin
  require 'httplog'
rescue LoadError
end

module SeeClickFix
  class SeeClickFix
    include HTTParty

    base_uri 'test.seeclickfix.com'

    def issues(options={})
      self.class.get('/api/v2/issues', { query: options })
    end
  end
end
