describe Restaurant do
  it 'it not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: "kf")
    expect(restaurant).not_to be_valid
  end

end
