require 'rails_helper'

RSpec.describe "fruits/index", type: :view do
  before(:each) do
    assign(:fruits, [
      Fruit.create!(
        :type => "Type",
        :price => 2.5,
        :description => "MyText",
        :display_url => "Display Url"
      ),
      Fruit.create!(
        :type => "Type",
        :price => 2.5,
        :description => "MyText",
        :display_url => "Display Url"
      )
    ])
  end

  it "renders a list of fruits" do
    render
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Display Url".to_s, :count => 2
  end
end
