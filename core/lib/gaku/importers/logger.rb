module Gaku::Importers::Logger
  @logger
  def log(msg)
    if !@logger.nil?
      @logger.info(msg)
    else
      puts msg
    end
  end
end
