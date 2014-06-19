#!/usr/bin/env ruby

require 'soap/wsdlDriver'
require 'yaml'

class SsoTokenError < StandardError
end

class NbUrnClient

  def initialize(opts={})
    defaults = {config_file: nil, username: nil, password: nil}
    opts = opts.inject({}){|h,(k,v)| h[k.to_sym] = v; h}
    opts = defaults.merge(opts)
    @config = YAML.load(open(opts[:config_file]))['config']['urn']
    @config = @config.inject({}){|h,(k,v)| h[k.to_sym] = v; h}
    @client = SOAP::WSDLDriverFactory.new(@config[:wsdl]).create_rpc_driver
    @sso_token = nil
    @config[:username] = opts[:username] ||= @config[:username]
    @config[:password] = opts[:password] ||= @config[:password]
  end

  def add_url(urn, url)
    if not @sso_token.nil?
      return @client.addURL({'SSOToken' => @sso_token,
                              'URN' => urn,
                              'URL' => url})
    else
      raise SsoTokenError("No SSO token available. You need to login first.")
    end
  end
  
  def create_urn(series_code, url)
    if not @sso_token.nil?
      return @client.createURN({'SSOToken' => @sso_token, 
                                 'seriesCode' => series_code,
                                 'URL' => url})
    else
      raise SsoTokenError("No SSO token available. You need to login first.")
    end
  end

  def delete_url(urn, url)
    if not @sso_token.nil?
      return @client.deleteURL({'SSOToken' => @sso_token, 
                                 'URN' => urn,
                                 'URL' => url})
    else
      raise SsoTokenError("No SSO token available. You need to login first.")
    end
  end

  def find_urn(urn)
    return @client.findURN({'URN' => urn})
  end

  def find_urns_for_url(url)
    return @client.findURNsForURL({'URL' => url})
  end

  def get_next_urn(series_code)
    if not @sso_token.nil?
      return @client.getNextURN({'SSOToken' => @sso_token, 
                                  'seriesCode' => series_code})
    else
      raise SsoTokenError("No SSO token available. You need to login first.")
    end
  end

  def login()
    result = @client.login({'username' => @config[:username],
                             'password' => @config[:password]})
    @sso_token = result['SSOToken']
    return @sso_token
  end

  def logout()
    if not @sso_token.nil?
      @client.logout({'SSOToken' => @sso_token})
      @sso_token = nil
    end
  end

  def register_urn(urn, url)
    if not @sso_token.nil?
      return @client.registerURN({'SSOToken' => @sso_token,
                                   'URN' => urn,
                                   'URL' => url})
    else
      raise SsoTokenError("No SSO token available. You need to login first.")
    end
  end

  def replace_url(urn, old_url, new_url)
    if not @sso_token.nil?
      return @client.replareURL({'SSOToken' => @sso_token, 
                                  'URN' => urn, 
                                  'oldURL' => old_url,
                                  'newURL' => new_url})
    else
      raise SsoTokenError("No SSO token available. You need to login first.")
    end
  end

  def reserve_next_urn(series_code)
    if not @sso_token.nil?
      return @client.reserveNextURN({'SSOToken' => @sso_token, 
                                      'seriesCode' => series_code})
    else
      raise SsoTokenError("No SSO token available. You need to login first.")
    end
  end

  def reserve_urn(urn)
    if not @sso_token.nil?
      return @client.reserveURN({'SSOToken' => @sso_token, 
                                  'URN' => urn})
    else
      raise SsoTokenError("No SSO token available. You need to login first.")
    end
  end

  def set_default_url(urn, url)
    if not @sso_token.nil?
      return @client.setDefaultURL({'SSOToken' => @sso_token, 
                                     'URN' => urn,
                                     'URL' => url})
    else
      raise SsoTokenError("No SSO token available. You need to login first.")
    end
  end
end

