class ProductsController < ApplicationController

    def index
        products=Product.all.sort 
        render json: products
    end
end