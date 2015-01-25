require 'rubygems'
require 'nokogiri'
require 'open-uri'

class WishlistScraper
  def initialize(filepath)
    @page = Nokogiri::HTML(open(filepath))
  end

  def get_books
    books = []
    @page.css(".a-fixed-right-grid-inner").each do |item|
      title = item.at_css('a').text.force_encoding("ISO-8859-1").strip
      author = item.at_css('.a-size-small').text.force_encoding("ISO-8859-1").strip.split(' by ')[-1]
      price = item.at_css('.a-color-price').text.strip
      asin = item.at_css('a')['href'].split('/')[1]
      created = item.at_css('.dateAddedText > span').text.strip
      books << Book.new(title: title, author: author, price: price, asin: asin, created_at: created)
    end
    books
  end
end


<a class="title" href="amamzon.com"

class Book
  attr_reader :author, :title, :price, :asin, :created_at
  def initialize(book_data)
    @author = book_data[:author]
    @title = book_data[:title]
    @price = book_data[:price]
    @asin = book_data[:asin]
    @created_at = book_data[:created_at]
  end
end
