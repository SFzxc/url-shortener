module RequestHelper
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def application_json
      before do
        headers['Content-Type'] = 'application/json'
        headers['Accept'] = 'application/json'
      end
    end

    def accept_json
      before do
        headers['Accept'] = 'application/json'
      end
    end
  end
end
