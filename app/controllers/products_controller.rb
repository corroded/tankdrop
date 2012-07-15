class ProductsController < ApplicationController

  respond_to :html, :json

  def new
    @product = Product.new
    respond_with @product
  end

  def index
    @products = Product.all
    respond_with(@products) do |format|
      format.html
      format.json {render :json => @products.collect{|product| product.to_jquery_upload }.to_json }
    end
  end

  def retrieve_products
    @products = Product.all
    render :json => @products.collect{|product| product.to_jquery_upload }.to_json
  end

  def upload
    
  end

  
  def create
    @product = Product.new(params[:product])
    if @product.save
      respond_to do |format|
        format.html {  
          render :json => [@product.to_jquery_upload].to_json, 
          :content_type => 'text/html',
          :layout => false
        }
        format.json {  
          render :json => [@product.to_jquery_upload].to_json			
        }
      end
    else
      render :json => [{:error => "unable to create image"}], :status => 304
    end
  end

    def destroy
      @product = Product.find(params[:id])
      @product.destroy
      render :json => true
    end

    def show
    @product = Product.find(params[:id])
  end

end
