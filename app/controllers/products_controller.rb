class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.try(:find,params[:id])
  end
  def traicaymienbac
  	
  end

  def traicaymiennam
  	
  end

  def traicaynhap
  	
  end
  def detailproduct
    
  end
  def orderdetailproduct

  end
end
