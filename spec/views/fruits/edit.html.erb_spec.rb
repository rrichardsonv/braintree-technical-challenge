require 'rails_helper'

RSpec.describe "fruits/edit", type: :view do
  before(:each) do
    @fruit = assign(:fruit, Fruit.create!(
      :type => "",
      :price => 1.5,
      :description => "MyText",
      :display_url => "MyString"
    ))
  end

  it "renders the edit fruit form" do
    render

    assert_select "form[action=?][method=?]", fruit_path(@fruit), "post" do

      assert_select "input#fruit_type[name=?]", "fruit[type]"

      assert_select "input#fruit_price[name=?]", "fruit[price]"

      assert_select "textarea#fruit_description[name=?]", "fruit[description]"

      assert_select "input#fruit_display_url[name=?]", "fruit[display_url]"
    end
  end
end
