require File.join(File.dirname(__FILE__), "base")

class Talk < Base

  load_path File.join(File.dirname(__FILE__), "../talks/")
  # load_path Rails.root.join("db/2011/talks")

end
