module Admin::ProductsHelper
  def categories
    Category.all
  end
end
