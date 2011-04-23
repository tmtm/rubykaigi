module EventResource

  class UnexpectedHandler < StandardError; end
  class UnexpectedResource < StandardError; end

  def self.handlers
    @@handlers ||= {}
  end

  def handle(handler)
    raise UnexpectedHandler unless [Symbol, String, Regexp, Proc].detect {|k| handler.is_a?(k) }
    EventResource.handlers[handler] = self
  end
 
  def self.get(id)
    handlers.each do |handler, klass|
      matche =  case handler
      when Symbol, String
        handler == id
      when Regexp
        handler =~ id.to_s
      when Proc
        handler.call(id)
      else
        false
      end
      return klass.get(id) if matche 
    end

    raise UnexpectedResource.new("resource key is not handled. (id: #{id.inspect})")
  end

end
