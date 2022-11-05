class ApplicationService
  include Exceptions

  def self.call(*args, &block)
    new(*args, &block).call
  end
end
