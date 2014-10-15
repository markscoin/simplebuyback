module HomeHelper

  def is_active?(link_path)
    if current_page?(link_path)
      "active"
    else
      ""
    end
  end

  def iphone?(src)
    keywords = Regexp.union("iphone 4","iphone 4s","iphone 5 ","iphone 5s","iphone 6")
    !!(src =~ keywords)
  end
  
  def keyword?(input,word)
    input.each do |x|
      keyword = Regexp.union("#{word}")
      return !!(x =~ keyword)
    end
  end
  
  def iphone_list
    @iphones = []
    @products = Spree::Product.all.map { |x| {id: x[:id], name: x[:name], slug: x[:slug]}}
    @products.each do |x|
      if iphone?(x[:name].downcase) && @iphones.include?(x[:name]) == false
        @iphones << x[:name].downcase
      end
    end
    @iphones
  end
  
end

