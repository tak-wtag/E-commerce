require 'openssl'
OpenSSL::SSL::SSLContext::DEFAULT_CERT_STORE = OpenSSL::X509::Store.new
OpenSSL::SSL::SSLContext::DEFAULT_CERT_STORE.set_default_paths
