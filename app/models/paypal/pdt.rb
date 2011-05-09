# -*- coding: utf-8 -*-
require 'net/https'
module Paypal
  class Pdt
    class << self
      def request(txn_id)
        pdt = new
        pdt.request(txn_id)
      end
    end

    attr_reader :url, :pdt_token
    def initialize
      config = configatron.paypal
      @url  = config.post_url
      @pdt_token = config.pdt_token
    end

    # need pass txn_id=value_of_transaction_token
    def request(txn_id)
      params = { "cmd" => "_notify-synch", "at" => pdt_token, 'tx' => txn_id}
      data = params.map {|k, v| "#{k}=#{CGI.escape(v)}" }.join("&")

      uri = URI.parse(@url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      http.ca_file = File.expand_path("cacert.pem", File.join(Rails.root, "certs"))
      response = http.start {
        http.post(uri.path, data)
      }
      result = HWIA.new
      if response.kind_of? Net::HTTPSuccess
        elements = response.body.split("\n")
        result['result'] = elements.shift
        case result['result']
        when 'SUCCESS'
          elements.each do |element|
            a = element.split("=")
            result[a[0]] = CGI.unescape(a[1]) if a.size == 2
          end
        when 'FAIL'
          result['detail'] = elements.join("\n")
        end
        result
      else
        result['result'] = 'ERROR!'
        result['detail'] = 'something went wrong on response from paypal'
      end
      result
    end
  end
end
