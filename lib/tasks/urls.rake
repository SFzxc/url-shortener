namespace :urls do
  desc 'Remove expired url to save disk space'
  task remove_expired_link: :environment do
    puts 'Scanning expired urls....'
    deleted_count = ShortenerUrl::ExpiredUrlCleanerService.call
    puts "Deleted #{deleted_count} expired links. Done!"
  end
end
