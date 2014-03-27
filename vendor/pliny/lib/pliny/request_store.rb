module Pliny
  module RequestStore
    def self.clear!
      Thread.current[:request_store] = {}
    end

    # A request-specific log store that will be added to all contextual logging
    # calls. Key data relating the request should be added here such as
    # request ID, authenticated user, etc.
    def self.log_context
      store[:log_context] ||= {}
    end

    # Request ID of the current request.
    def self.request_id
      store[:request_id]
    end

    def self.seed(env)
      store[:request_id] =
        env["REQUEST_IDS"] ? env["REQUEST_IDS"].join(",") : nil

      # a global context that evolves over the lifetime of the request, and is
      # used to tag all log messages that it produces
      log_context.merge! \
        request_id: env["REQUEST_IDS"] ? env["REQUEST_IDS"].join(",") : nil
    end

    protected

    def self.store
      Thread.current[:request_store] ||= {}
    end
  end
end
