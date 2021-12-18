class Public::CustomersController < ApplicationController
    
    def show
    @customer = Customer.find(params[:id])
    #customerのcustomerの内、いいねされたものを絞り込
    @relationship = Relationship.new
    
    @favorites = Favorite.where(customer_id: @customer.id)
    
    end
    
    
    
    #  @customers = current_customer.matchers
   
   def new
    
   @customer =  Customer.new
       
   end
  
  def create
      
  @customer = Customer.new(customer_params)
     
  if @customer.save
      redirect_to customer_path(customer)
  else
      render 'new'
  end
  
  end
  
  def edit
    
   @customer = Customer.find(params[:id])
   
   if @customer
    
   render:edit

   else

    redirect_to public_customer_path(current_customer)

   end

  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to public_customer_path(@customer), notice: "You have updated customer successfully."
    else
      render "edit"
    end
  end
  
  
  private

  def customer_params
    params.require(:customer).permit(:jobs,:seriousness,:moving_schedule)
  end
   
end
