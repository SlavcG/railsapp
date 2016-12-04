require 'rails_helper'

describe Product do

  before do
    @product = Product.create!(name: "rscpecprod", description: "exampletest", image_url: "images/example.png", price: 100, color: "white")
    @user = User.create!(email: "slavc@example.com", password: "example123")
    @product.comments.create!(rating: 1, user: @user, body: "Awful product!")
    @product.comments.create!(rating: 3, user: @user, body: "Good product!")
    @product.comments.create!(rating: 5, user: @user, body: "Perfect product!")
  end

  it "returns the average rating of all comments" do
    expect(@product.average_rating).to eq 3
  end

  it "is not valid" do
    expect(Product.new(description: "Nice bike")).not_to be_valid
  end

end
