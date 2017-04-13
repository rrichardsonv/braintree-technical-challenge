require 'rails_helper'

RSpec.describe "fruits/new", type: :view do
  before(:each) do
    assign(:fruit, Fruit.new(
      :type => "",
      :price => 1.5,
      :description => "MyText",
      :display_url => "MyString"
    ))
  end

  it "renders new fruit form" do
    render

    assert_select "form[action=?][method=?]", fruits_path, "post" do

      assert_select "input#fruit_type[name=?]", "fruit[type]"

      assert_select "input#fruit_price[name=?]", "fruit[price]"

      assert_select "textarea#fruit_description[name=?]", "fruit[description]"

      assert_select "input#fruit_display_url[name=?]", "fruit[display_url]"
    end
  end
end
