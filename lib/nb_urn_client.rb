#!/usr/bin/env ruby

require 'soap/wsdlDriver'
require 'yaml'

class SsoTokenError < StandardError
end

class NbUrnClient

  def initialize(opts={})
    defaults = {config_file: nil, username: nil, password: nil}
    opts = defaults.merge(opts)
    @config = YAML.load(open(opts[:config_file]))['config']['urn']
    @client = SOAP::WSDLDriverFactory.new(@config['wsdl']).create_rpc_driver
    @client.return_response_as_xml = true
    @sso_token = nil
    @config['username'] = username ||= @config['username']
    @config['password'] = password ||= @config['password']
  end

  def add_url(urn, url)
    if @sso_token
      return @client.addURL(@sso_token, urn, url)
    else
      raise SsoTokenError("No SSO token available. You need to login first.")
    end
  end
  
  def create_urn(series_code, url)
    if @sso_token
      return @client.createURN(@sso_token, series_code, url)
    else
      raise SsoTokenError("No SSO token available. You need to login first.")
    end
  end

  def delete_url(urn, url)
    if @sso_token
      return @client.deleteURL(@sso_token, urn, url)
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
    if @sso_token
      return @client.getNextURN(@sso_token, series_code)
    else
      raise SsoTokenError("No SSO token available. You need to login first.")
    end
  end

  def login()
    return @client.login(@client.config['username'], @client.config['password'])
  end

  # def login(username, password)
  #   return @client.login(username, password)
  # end

  def logout()
    if @sso_token
      @client.service.logout(@sso_token)
      @sso_token = nil
    end
  end

  def register_urn(urn, url)
    if @sso_token
      return @client.registerURN(@sso_token, urn, url)
    else
      raise SsoTokenError("No SSO token available. You need to login first.")
    end
  end

  def replace_url(urn, old_url, new_url)
    if @sso_token
      return @client.replareURL(sso_token, urn, old_urn, new_url)
    else
      raise SsoTokenError("No SSO token available. You need to login first.")
    end
  end

  def reserve_next_urn(series_code)
    if @sso_token
      return @client.reserveNextURN(@sso_token, series_code)
    else
      raise SsoTokenError("No SSO token available. You need to login first.")
    end
  end

  def reserve_urn(urn)
    if @sso_token
      return @client.reserveURN(@sso_token, urn)
    else
      raise SsoTokenError("No SSO token available. You need to login first.")
    end
  end

  def set_default_url(urn, url)
    if @sso_token
      return @client.setDefaultURL(@sso_token, urn, url)
    else
      raise SsoTokenError("No SSO token available. You need to login first.")
    end
  end
end

