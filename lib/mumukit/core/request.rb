require 'rack/request'

module Rack
  class Request
    def first_subdomain
      @env['rack.env.subdomains'] ||= extract_subdomains
    end

    def organization_name
      first_subdomain || 'central'
    end

    private

    def extract_subdomains
      raise 'no host set' unless host
      raise 'set hostname first!' if /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/.match(host)
      return nil if host == 'localhost'
      (host.split('.') - ['mumuki', 'io'])[0]
    end
  end
end