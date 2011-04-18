# -*- coding: utf-8 -*-
require File.expand_path('../../../spec_helper', __FILE__)

describe '_nicovideo_link.html.haml' do
  context 'without part number' do
    before do
      render :partial =>'events/nicovideo_link', :locals => {:item_id => 'sm0000001', :link_text => t(:nicovideo)}
    end
    it { response.should have_selector('a', :content => t(:nicovideo)) }
  end

  context 'with part number' do
    before do
      render :partial =>'events/nicovideo_link', :locals => {:item_id => 'sm0000001', :link_text => t(:nicovideo) + ' (Part 1)'}
    end
    it { response.should have_selector('a', :content => t(:nicovideo) + ' (Part 1)') }
  end
end
