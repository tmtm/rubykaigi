# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'

describe PagesController do
  context "page does not found" do
    render_views

    specify do
      expect {
        get :show, :year => '2010', :page_name => 'page_doesn_not_exist', :locale => 'ja'
      }.to_not raise_error(ActionView::MissingTemplate)
    end

    specify do
      get :show, :year => '2010', :page_name => 'page_doesn_not_exist', :locale => 'ja'
      response.status.should == 404
    end
  end
end
