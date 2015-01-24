require 'rubygems'
require 'nokogiri'
require 'open-uri'

class WishlistScraper
  def initialize(wishlist_data)
    @wishlist_id = wishlist_data[:id]
    @filepath =    wishlist_data[:filepath]
    @url =         wishlist_data[:url]
  end

  def load_page
    if @filepath
      @page = Nokogiri::HTML(open(@filepath))
    elsif @url
      @page = Nokogiri::HTML(open(@url))
    elsif @wishlist_id
      @page = Nokogiri::HTML(open("http://www.amazon.com/wishlist/#{@wishlist_id}/"))
    end
  end

  def get_books
    books = []
    item_elements = @page.css(".g-span7when-wide")
    item_elements.each do |item|
      book_data = {}
      book_data[:title] = item.at_css(".a-link-normal").text.force_encoding("ISO-8859-1").strip
      book_data[:author] = item.at_css(".a-size-small").text.force_encoding("ISO-8859-1").split("by")[-1].strip
      book_data[:price] = item.at_css(".a-color-price").text.force_encoding("ISO-8859-1").strip
      book_data[:price] = "N/A" unless book_data[:price].include?("$")
      book_data[:asin] = item.at_css(".a-link-normal")["href"].split("/")[2].force_encoding("ISO-8859-1").strip
      books << Book.new(book_data)
    end
    return books
  end
end

class Book
  attr_reader :asin, :title, :author, :price
  def initialize(book_data)
    @asin = book_data[:asin]
    @title = book_data[:title]
    @author = book_data[:author]
    @price = book_data[:price]
  end
  def to_s
    "#{title}\n#{author}\n#{price}\n#{asin}"
  end
end
