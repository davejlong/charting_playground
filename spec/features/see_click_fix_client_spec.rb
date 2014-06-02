require 'spec_helper'

feature 'SeeClickFix API Client' do
  it 'queries top issues from SeeClickFix API' do
    endpoint = SeeClickFix::SeeClickFix.new
    response = endpoint.issues
    expect(response.headers['content-type']).to match(/^application\/json/)
  end

  context 'when provided search context' do
    it 'queries top issues from specific town' do
      endpoint = SeeClickFix::SeeClickFix.new
      response = endpoint.issues search: 'wallingford'
      expect(response.headers['content-type']).to match(/^application\/json/)
    end
  end
end
