RSpec.describe ShortenerUrl::ExpiredUrlCleanerService, type: :model do
  describe '#call' do
    let(:id1) { 'V5FakZw' }
    let(:id2) { 'XlcJHbi' }
    let(:expired_at) { 1.hours.ago }
    let(:original_url) { 'https://twitter.com/home' }

    before(:each) do
      create(:url, short_url: id1, original_url: original_url)
      create(:url, short_url: id2, original_url: original_url, expired_at: expired_at)
    end

    it 'should clean all expired urls' do
      ShortenerUrl::ExpiredUrlCleanerService.call
      expect(Url.count).to eq(1)
    end
  end
end
