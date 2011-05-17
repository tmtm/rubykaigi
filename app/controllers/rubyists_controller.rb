class RubyistsController < LocaleBaseController
  layout_for_latest_ruby_kaigi

  def show
    @rubyist = Rubyist.find_by_username(params[:id])
    unless @rubyist
      render :status => '404', :file => 'public/404.html', :layout => false
    end
  end
end
