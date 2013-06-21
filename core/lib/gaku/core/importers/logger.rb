module Gaku::Core::Importers::Logger
  @logger
  def log(msg)
    unless @logger.nil?
      @logger.info(msg)
    else
      puts msg
    end
  end
end
