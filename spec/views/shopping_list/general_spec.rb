require 'rails_helper'

RSpec.describe 'shopping_list/general.html.erb', type: :view do
  before do
    assign(:total_items, 10)
    assign(:general_total_price, 50.0)
    assign(:missing_foods, [
             { food: Food.new(name: 'Apple', measurement_unit: 'Pieces', price: 1.5), deficit_quantity: 5 }
           ])

    render
  end

  it 'displays the heading' do
    expect(rendered).to have_selector('h1', text: 'General Shopping List')
  end

  it 'displays the total number of items' do
    expect(rendered).to have_selector('h5', text: 'Amount of food items to buy: 10')
  end

  it 'displays the total value of food needed' do
    expect(rendered).to have_selector('h5', text: 'Total value of food needed:  50.0')
  end

  it 'displays a table with missing foods' do
    expect(rendered).to have_selector('table.table-striped.table-hover.table-sm.table-bordered')
    expect(rendered).to have_selector('th', text: 'Food')
    expect(rendered).to have_selector('th', text: 'Quantity')
    expect(rendered).to have_selector('th', text: 'Price')
    expect(rendered).to have_selector('tr', count: 2)
    expect(rendered).to have_selector('td', text: 'Apple')
    expect(rendered).to have_selector('td', text: '5 Pieces')
    expect(rendered).to have_selector('td', text: '$1.5')
  end
end
