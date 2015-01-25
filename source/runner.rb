load 'wishlist_scraper.rb'
#
wishlister = WishlistScraper.new('example.html')
wishlister.get_books.each do |book|
  puts book.title
  puts book.author
  puts book.price
  puts book.asin
end
