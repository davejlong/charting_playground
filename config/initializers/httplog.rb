begin
  require 'httplog'

  HttpLog.options[:log_response] = false
rescue LoadError
end

