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
    raise NotImplementedError
    # if @sso_token
    #   pass
    # else
    #   raise SsoTokenError("No SSO token available. You need to login first.")
    # end
  end
  
  def create_urn(series_code, url)
    raise NotImplementedError
    # if @sso_token
    #   pass
    # else
    #   raise SsoTokenError("No SSO token available. You need to login first.")
    # end
  end

  def delete_url(urn, url)
    raise NotImplementedError
    # if @sso_token
    #   pass
    # else
    #   raise SsoTokenError("No SSO token available. You need to login first.")
    # end
  end

  def find_urn(urn)
    c = @client.findURN({'URN' => urn})
    return c
  end

  def find_urns_for_url(url)
    c = @client.findURNsForURL({'URL' => url})
    return c
  end

  def get_next_urn(series_code)
    raise NotImplementedError
    # if @sso_token
    #   pass
    # else
    #   raise SsoTokenError("No SSO token available. You need to login first.")
    # end
  end

  def login(username, password)
    return
  end

  def logout()
    raise NotImplementedError
  #   if @sso_token
  #     @client.service.logout(@sso_token)
  #     @sso_token = nil
  #   end
  end

  def register_urn(urn, url)
    raise NotImplementedError
    # if @sso_token
    #   pass
    # else
    #   raise SsoTokenError("No SSO token available. You need to login first.")
    # end
  end

  def replace_url(urn, old_url, new_url)
    raise NotImplementedError
    # if @sso_token
    #   pass
    # else
    #   raise SsoTokenError("No SSO token available. You need to login first.")
    # end
  end

  def reserve_next_urn(series_code)
    raise NotImplementedError
    # if @sso_token
    #   pass
    # else
    #   raise SsoTokenError("No SSO token available. You need to login first.")
    # end
  end

  def reserve_urn(urn)
    raise NotImplementedError
    # if @sso_token
    #   pass
    # else
    #   raise SsoTokenError("No SSO token available. You need to login first.")
    # end
  end

  def set_default_url(urn, url)
    raise NotImplementedError
    # if @sso_token
    #   pass
    # else
    #   raise SsoTokenError("No SSO token available. You need to login first.")
    # end
  end
end

