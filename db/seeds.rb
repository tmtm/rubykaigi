%w(ruby_kaigis product_items).each do |t|
  conn = ActiveRecord::Base.connection
  conn.execute("truncate #{t};")
  conn.execute("alter table #{t} auto_increment = 1;")
end

(2006..2009).to_a.each do |year|
  RubyKaigi.create(:year => year, :capacity => 0, :party_capacity => 0)
end
rk10 = RubyKaigi.create(:year => 2010, :capacity => 900, :party_capacity => 310,
  :registration_open_at => DateTime.parse('2010-05-26 20:59:59'))
ProductItem.create(:item_code => 'rk10', :unit_price => 6000, :stock => 700, :ruby_kaigi => rk10,
  :open_sale_at => DateTime.parse('2010-06-15 19:00:00'), :ready_for_sale => true)
ProductItem.create(:item_code => 'rk10_party', :unit_price => 5000, :stock => 50, :ruby_kaigi => rk10,
  :open_sale_at => DateTime.parse('2010-05-26 20:59:59'), :ready_for_sale => true)
ProductItem.create(:item_code => 'rk10_individual_sponsor', :unit_price => 20000, :stock => 100, :ruby_kaigi => rk10,
  :open_sale_at => DateTime.parse('2010-05-26 20:59:59'), :ready_for_sale => true)

rk11 = RubyKaigi.create(:year => 2011, :capacity => 1000, :party_capacity => 450)
ProductItem.create(:item_code => 'rk11', :unit_price => 6000, :stock => 700, :ruby_kaigi => rk11,
  :open_sale_at => DateTime.parse('2011-05-22 10:00:00'), :ready_for_sale => true)
ProductItem.create(:item_code => 'rk11_party', :unit_price => 5000, :stock => 200, :ruby_kaigi => rk11,
  :open_sale_at => DateTime.parse('2011-05-22 10:00:00'), :ready_for_sale => true)
ProductItem.create(:item_code => 'rk11_individual_sponsor', :unit_price => 15000, :stock => 200, :ruby_kaigi => rk11,
  :open_sale_at => DateTime.parse('2011-05-17 20:30:00'), :ready_for_sale => true)
