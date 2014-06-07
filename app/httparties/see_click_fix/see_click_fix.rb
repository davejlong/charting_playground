module SeeClickFix
  class SeeClickFix
    include HTTParty

    base_uri 'seeclickfix.com'

    def issues(options={})
      result = get_from_cache(options)
      if result.nil?
        result = self.class.get('/api/v2/issues', { query: options })
        set_into_cache(options, result)
      end
      result
    end

    private

    def get_from_cache(options={})
      Rails.cache.fetch cache_key_from_options(options)
    end

    def set_into_cache(options={}, dataset)
      Rails.cache.fetch(cache_key_from_options(options), expires_in: 10800) { dataset.as_json }
    end

    def cache_key_from_options(options)
      (options.empty? ? 'global_issues' : options.values.join('_'))
    end
  end
end
