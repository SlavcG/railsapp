class PaymentsController < ApplicationController

  def create
    @product = Product.find(params[:product_id])
    @user = current_user
    token = params[:stripeToken]
    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      charge = Stripe::Charge.create(
        :amount => @product.price,
        :currency => "usd",
        :source => token,
        :description => params[:stripeEmail]
      )

      if charge.paid
        Order.create!(product_id: @product.id, user_id: @user_id, total: @product.price)
        UserMailer.paid_success(@user, @product).deliver_now
        flash[:success] = "Payment was successful."
      end

    rescue Stripe::CardError => e
      # The card has been declined
      body = e.json_body
      err = body[:error]
      flash[:error] = "Unfortunately, there was an error processing your payment: #{err[:message]}"
    end

    redirect_to products_path(@product)

  end

  private
    def payment_params
      params.require(:payment).permit()
    end

end
