# -*- coding: utf-8 -*-
module CartsHelper
  def proceed_to_checkout_button
    link_to(image_tag("/2011/images/cartsBtnProceedToCheckout.png", :alt => "Proceed to checkout(購入手続きへ進む)"), orders_path, :method => :post)
  end
end
