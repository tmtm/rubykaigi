class SponsorsRubyController < LocalBaseController
  layout_for_latest_ruby_kaigi

  def show
    @sponsor = RubyKaigi2011::RubySponsor.find(params[:id])
  end
end
