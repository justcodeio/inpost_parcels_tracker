require "inpost_parcels_tracker/version"
require 'net/http'
require 'active_support/all'

module Inpost
  class Parcel
    HOST = 'https://api-shipx-pl.easypack24.net/v1/tracking/'.freeze

    def initialize(tracking_code)
      raise 'Tracking code cannot be nil' if tracking_code.blank?
      raise 'Invalid tracking code provided' if tracking_code.size < 24
      @tracking_code = tracking_code
    end

    def request(args = {})
      method        = args.fetch(:method,         :GET)
      path          = args.fetch(:path,           '')
      path = '/' + path if path[0] != '/' && path.size >= 1
      response = nil

      Net::HTTP.start(uri.host,uri.port,
                      use_ssl: uri.scheme == 'https',
                      open_timeout: 2.minutes,
                      read_timeout: 2.minutes,
                      keep_alive_timeout: 20.seconds,
                      verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
        case method
        when :GET, :get
          req = Net::HTTP::Get.new uri(path: path)
        else
          raise 'Unexpected method: ' + method
        end
        response = http.request(req)
      end
      parse(response.body)
    end

    def parse(body)
      JSON.parse(body.gsub(/\{\} && /, '')).deep_symbolize_keys
    end

    def track
      request(method: :get, path: @tracking_code)
    end

    def uri(args = {})
      URI.parse(HOST + args.fetch(:path, ''))
    end
  end
end
