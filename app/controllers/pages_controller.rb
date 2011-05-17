# coding: utf-8
class PagesController < LocaleBaseController
  skip_before_filter :login_required
  before_filter :readonly
  before_filter :page_name_is_valid
  before_filter :redirect_to_past_kaigi

  layout_for_latest_ruby_kaigi

  def show
    case params[:year]
    when '2009', '2010'
      # XXX: existing static pages should be handled before
      page_name = params[:page_name]
      if page_name == 'index' || page_name.blank?
        render :file => "public/#{params[:year]}/#{params[:locale]}/index.html"
      else
        render :file => 'public/404.html', :status => 404, :layout => false
      end
      return
    when "2011"
      begin
        if params[:page_name] =~ /^phone/
          render :template => "pages/2011/#{params[:page_name]}", :layout => "ruby_kaigi2011_phone"
        else
          render :template => "pages/2011/#{params[:page_name]}", :layout => "ruby_kaigi2011"
        end
      rescue ActionView::MissingTemplate => e
        render :file => "public/404.html", :status => 404, :layout => false
      end
      return
    end

    # params[:page_name] pass white list at `page_name_is_valid'
    begin
      render :template => "ruby_kaigi2009/#{params[:page_name]}_#{I18n.locale}"
    rescue Errno::ENOENT, ActionView::MissingTemplate => e
      alternative = Dir.glob(Rails.root + "app/views/ruby_kaigi2009/#{params[:page_name]}*").first
      if File.exist? alternative
        alt_locale = alternative.split("_").last.split(".").first
        redirect_to(:action => :show, :year => params[:year], :page_name => params[:page_name], :locale => alt_locale)
      else
        raise e
      end
    end
  end

  private
  def readonly
    raise MethodNotAllowd unless request.get? # FIXME: typo
  end

  def page_name_is_valid
    head(:not_found) unless /\A[A-Za-z0-9_\-]*\Z/ =~ params[:page_name]
  end

  def redirect_to_past_kaigi
    if (year = params[:year].to_i) < 2009
      redirect_to "http://jp.rubyist.net/RubyKaigi#{year}"
    elsif 2011 < year
      render :file => "public/404.html", :status => 404, :layout => false
    else
      true
    end
  end

  def sponsors_only
    return basic_auth_required_by_sponsor if params[:page_name] == "Sponsors"
    true
  end
end
