load 'wishlist_scraper.rb'

wishlister = WishlistScraper.new(id: "25OHJLUZBMXAY")
wishlister.load_page
books = wishlister.get_books
books.each {|book| puts book}
