load 'wishlist_scraper.rb'

wishlister = WishlistScraper.new(filepath: "example.html")
wishlister.load_page
books = wishlister.get_books
books.each {|book| puts book}
