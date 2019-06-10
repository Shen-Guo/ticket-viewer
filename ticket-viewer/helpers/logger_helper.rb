require "logger"
require_relative "../config/configuration"

class Log
  def self.log_error(message)
    log_file = File.new("log_file.txt", "a+")
    logger = Logger.new(log_file)
    logger.error(message)
    logger.close
  end
end
