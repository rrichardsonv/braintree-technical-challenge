require 'rails_helper'

RSpec.describe "Fruits", type: :request do
  describe "GET /fruits" do
    it "works! (now write some real specs)" do
      get fruits_path
      expect(response).to have_http_status(200)
    end
  end
end
