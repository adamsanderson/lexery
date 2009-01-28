module Publisher
  Subscriber = Struct.new :subscriber, :block
  
  def subscribers
    @subscribers ||= Hash.new{|h,k| h[k] = [] }
  end
  
  def subscribe(event, subscriber=nil, &block)
    validate_event! event
    subscribers[event] << Subscriber.new(subscriber, block)
  end
  
  def unsubscribe(event, subscriber=nil)
    validate_event! event
    subscribers[event].delete_if{|s| s.subscriber == subscriber}
  end
  
  def fire_event(event, *args)
    validate_event! event
    subscribers[event].each{|sub| sub.block.call(*args)}
  end
  
  def validate_event!(event)
    raise "No such event '#{event}', should be one of #{self.class.events.inspect}" unless self.class.events.include? event
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def events(*events)
      @pub_sub_events ||= []
      if events.empty?
        inherited_events = superclass.respond_to?(:events) ? superclass.send(:events) : []
        [@pub_sub_events, inherited_events].flatten
      else
        @pub_sub_events.insert(0,*events)
      end
      
    end    
  end
end