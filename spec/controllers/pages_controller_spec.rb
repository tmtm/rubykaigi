# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'

describe PagesController do
  context "page does not found" do
    integrate_views

    it 'should not raise missing template exception' do
      %w{2009 2010}.each do |year|
        %w{ja en}.each do |locale|
          lambda {
            get :show, {:year => year, :page_name => 'page_does_not_exist', :locale => locale}
          }.should_not raise_exception(ActionView::MissingTemplate)
        end
      end
    end

    it 'should return HTTP 404' do
      %w{2009 2010}.each do |year|
        %w{ja en}.each do |locale|
          get :show, {:year => year, :page_name => 'page_does_not_exists', :locale => locale}
          response.status.should == '404 Not Found'
        end
      end
    end
  end
end
