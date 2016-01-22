require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

    test "attributes of product may not be empty" do
    product = Product.new
    
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end
  
  
  
  test "price of product must be greater than 0" do
  product = Product.new(title: "XO Drone",
                        description: "Most advanced drone.",
                        image_url: "nixie.jpg")
  product.price = -1
  assert product.invalid?
  assert_equal ["must be greater than or equal to 0.01"],
    product.errors[:price]
    
  product.price = 0
  assert product.invalid?
  assert_equal ["must be greater than or equal to 0.01"],
    product.errors[:price]
    
  product.price = 1
  assert product.valid?
  
  end
  
  def new_product(image_url)
    Product.new(title: "XS Drone",
                description: "Smallest drone",
                price: 500,
                image_url: image_url)
  end
    
    test "image_url" do
      ok = %w{ joe.gif joe.jpg joe.png JOE.JPG JOE.Jpg
        http://a.b.c/x/y/z/joe.gif }
      bad = %w{ joe.doc joe.gif/more joe.gif.more }
      
      ok.each do |name|
        assert new_product(name).valid?, "#{name} should be valid"
      end
      bad.each do |name|
        assert new_product(name).invalid?, "#{name} shouldn't be valid"
      end
  end
end
