class RegistrationsController < LocaleBaseController
  layout_for_latest_ruby_kaigi

  def index
    set_product_item
    render "pages/2011/registration"
  end
  def phone_index
    set_product_item
    render "pages/2011/phone_registration", :layout => "ruby_kaigi2011_phone"
  end
  def set_product_item
    @individual_sponsor = ProductItem.find_by_item_code('rk11_individual_sponsor')
    @kaigi = ProductItem.find_by_item_code("rk11")
    @party = ProductItem.find_by_item_code("rk11_party")
  end
end
