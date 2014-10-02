=begin  This is a custom crawler to scrape usell.com for pricing information
It saves all the information into a csv file within the the same directory. USell is
structured so that their url contains the product number (xxxxx) with the condition (41-43) at
the end of the url. - M.O.
Condition 41 = Broken
Condition 42 = Good
Condition 43 = Flawless
=end

require 'csv'
require 'rubygems'
require 'nokogiri'
require 'open-uri'

HEADERS_HASH = {"User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:29.0) Gecko/20100101 Firefox/29.0"}
base_url = "http://www.usell.com/offers/samsung-galaxy-s-iii-sgh-i747--at-t-/"

CSV.open("results.csv", "ab") do |csv|
  product_number = 13900
  condition = 43
  @start_pattern = false
  @switch = 0
  @trigger = 0
  while product_number < 14302 do
    list_url = "#{base_url}#{product_number}.htm?answerIds=#{condition}"
    response = open(list_url) rescue nil
    unless response
      product_number += 1
      next
    end
    @page = Nokogiri::HTML(open(list_url))
    puts "Opening Product Number: #{product_number}(Condition: #{condition})"
    @dollars = @page.css("div.value p").first.text rescue @dollars = []
    @title = @page.css("div#page_title h1 span").text

    #this checks to see if the resulting page is blank and if it is it just continues with the pattern. If its not blank it will gather the 3 prices (condition)
    if @dollars.empty? && condition > 41 #added in conditional for condition so that even if they are missing a purchase price for broken condition at least it will save good and flawless price
      @start_pattern = true
    elsif condition == 43 #Flawless Condition
      @flawless = @dollars
      puts "Saved Flawless Price: #{@dollars}"
      condition -= 1
      @start_pattern = false
    elsif condition == 42 #Good Condition
      @good = @dollars
      puts "Saved Good Price: #{@dollars}"
      condition -= 1
      @start_pattern = false
    elsif condition == 41 #Broken Condition
      csv << [ product_number, @title , @dollars, @good, @flawless]
      puts "Writing Prices: #{@dollars}, #{@good}, #{@flawless}"
      condition = 43
      @start_pattern = true
    end


    # This makes it so that the PRODUCT ID portion of the url changes in the pattern +3 -2 +3 -2 +3  repeat. With this pattern all products will be covered
    if @start_pattern == true
      if @trigger % 5 == 0
       product_number += 3
        @trigger += 1
        @switch = 1
      else
        if @switch == 0
          product_number = product_number + 3
          @switch = 1
          @trigger += 1
        elsif @switch == 1
          product_number = product_number - 2
          @switch = 0
          @trigger += 1
        end
      end
    end
    sleep 1.0 + rand
  end
end


=begin  Below are the targets for product page where you select the condition
 ("div.offer-value span:nth-child(2)")   targets the cents on the product page
 .xpath('//div[@class="offer-value"]/text()[2]') targets the dollar amount on the products page
=end