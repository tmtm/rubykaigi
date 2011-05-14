module OrdersHelper
  def checkout_paypal_button
#    checkout_paypal_button = (current_locale == "ja" ? image_tag("/2010/images/checkout_paypal_ja.png", :alt => "PayPalでチェックアウトする") : image_tag("/2010/images/checkout_paypal_en.png", :alt => "Checkout via PayPal"))
#    link_to(addtocart_button, orders_path, :method => :post, :class => 'noborder')
    image_submit_tag("/2011/images/cartsBtnCheckoutViaPayPal.png")
  end
end
