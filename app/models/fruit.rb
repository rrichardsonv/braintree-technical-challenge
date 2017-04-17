class Fruit < ApplicationRecord
  def product_path
    ['/fruits',self.id].join('/')
  end
end
