require 'rails_helper'

RSpec.describe "fruits/show", type: :view do
  before(:each) do
    @fruit = assign(:fruit, Fruit.create!(
      :type => "Type",
      :price => 2.5,
      :description => "MyText",
      :display_url => "Display Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Type/)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Display Url/)
  end
end
