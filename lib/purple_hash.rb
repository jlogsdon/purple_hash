class PurpleHash < ::Hash
  class HashFrozen < RuntimeError
    def initialize
      super('this PurpleHash is frozen')
    end
  end

  def initialize(hash={})
    configure_from_hash(hash)
    @__frozen = false
  end

  def freeze!
    self.each do |k, h|
      h.freeze! if h.respond_to?(:freeze!)
    end
    @__frozen = true
  end

  def frozen?
    @__frozen === true
  end

  def configure_from_hash(hash)
    hash.each do |key, value|
      if value.is_a?(Hash)
        self[key].configure_from_hash(value)
      else
        self[key] = value
      end
    end
  end

  def [](key)
    super(key.to_sym)
  end

  def []=(key, value)
    raise HashFrozen if frozen?

    if value.is_a?(Hash) && !value.is_a?(self.class)
      self[key].configure_from_hash(value)
    else
      super(key.to_sym, value)
    end
  end

  def default(key)
    return nil if frozen?
    self[key] = PurpleHash.new
  end

  def default=(*args)
    raise RuntimeError, "#{self.class} does not allow changing the default hash value"
  end
end
