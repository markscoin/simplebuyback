require 'csv'
require 'rubygems'
require 'spree'

#Removes $ from price and changes it to float
class String
  def cost_to_f
    self.delete('$,').to_f
  end
end
  
crawler_data = []
CSV.foreach("usell_products.csv") do |x|
  crawler_data << x
end

#crawler data formatted 
formatted_crawler_data = crawler_data.map {|x| {product_id: x[0], name: x[1], price:"#{x[2].cost_to_f}|#{x[3].cost_to_f}|#{x[4].cost_to_f}"}}.sort_by { |x| x[:id]}


#Gathers current spree product data into an array 
products = Spree::Product.all.map { |x| { product_id: x.id , name: x.name }}
prices = Spree::Price.all.map {|x| {variant_id: x.variant_id, price: x.amount.to_f}}
variants = Spree::Variant.all.map { |x| { variant_id: x.id, position: x.position, product_id: x.product_id }}
variants_prices = variants.map { |x| x.merge (prices.find { |y| y[:variant_id] == x[:variant_id] } || {})}
all_together = variants_prices.map { |x| x.merge (products.find {|y| y[:product_id] == x[:product_id]} || {})}
group_by = all_together.group_by {|x| x[:product_id]}
mapped = group_by.map {|x,y| {product_id: x, price: y.map{|x| x[:price]}.sort[1..-1].join('|'), name: y.map{|j| j[:name]}}}
completed_format = mapped.map {|x| {product_id: x[:product_id], price: x[:price], name: x[:name].first}}.sort_by { |x| x[:product_id]}

#Method to check if string contains a brand name 
def brandname?(src)
  keywords = Regexp.union("samsung","apple","blackberry","htc","nokia", "motorola")
  !!(src =~ keywords)
end

#Comparison of the two sets of data

#Overwrites preexisting file and inputs the correct header 
CSV.open("updates_needed.csv", "w") do |csv|
  csv << ["id","SKU",	"price", "name", "description", "available_on",	"shipping_category_id",	"option_types","variant_price"]
end

formatted_crawler_data.each do |x|
  new_product_prices = x[:price].split('|').flatten.collect { |w| w.to_f}
  new_calculated_prices = []
  new_product_prices.each { |z| new_calculated_prices << (((z * 0.97)/2).round(0)*2) } # changes prices 
  new_prices_csv = new_calculated_prices.join('|') #Gets new calculated prices ready for csv 
  #Finds a match by name
  if completed_format.find { |y| y[:name] == x[:name] }
    current_product = completed_format.find { |y| y[:name] == x[:name] }    
    if current_product[:price] != x[:price]
      current = current_product[:price].split('|')
      current_product_prices = current.flatten.collect { |j| j.to_f}
      i = 0
      CSV.open("notifications.csv", "w") do |notify|
        while i < 3 do
        if current_product_prices[i]/new_product_prices[i] > 1.2 || current_product_prices[i]/new_product_prices[i] < 0.8
          notify << [current_product[:product_id], x[:name], new_product_prices]
          puts "Notification! #{x[:name]}"
          break
        else
          puts "Saved Update #{x[:name]}!"
        end
          i += 1
        end
      end
      
      CSV.open("updates_needed.csv", "ab") do |csv|
        csv << [ current_product[:product_id], "" ,0, x[:name],"","",1,"Condition:Broken,Good,Flawless", new_prices_csv]   
      end
    end
  #checks if crawler data row contains brandname and if it does, is it worth including(based on buyback amount)
  elsif brandname?(x[:name].downcase.to_s)
    prices = x[:price].split('|').flatten.collect { |w| w.to_f}
    if prices[2] > 30
      CSV.open("updates_needed.csv", "ab") do |csv|
        csv << [ x[:product_id], "" ,0, x[:name],"","",1,"Condition:Broken,Good,Flawless", new_prices_csv]
      end
      puts "Saved Update #{x[:name]}"
    end
  else
    CSV.open("excluded.csv", "ab") do |csv|
      csv << [ x[:product_id], "" ,0, x[:name],"","",1,"Condition:Broken,Good,Flawless", new_prices_csv]
      puts "Excluded #{x[:name]}"
    end
  end
end



