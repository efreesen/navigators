module Navigators
  class Base
    attr_reader :listener

    def initialize(listener)
      @listener = listener
    end

    def self.index(listener)
      self.new(listener).index
    end

    def index
      listener.render_resources(get_resources)
    end

    def self.show(id, listener)
      self.new(listener).show(id)
    end

    def show(id)
      listener.render_resource(get_resource(id))
    end

    def self.save(params, listener, id=nil)
      self.new(listener).save(params, id)
    end

    def save(params, id=nil)
      @action = id ? :edit : :new
      get_resource(id)

      if save_resource(params)
        listener.save_success(resource, success_message)
      else
        listener.save_failure(resource, error_message)
      end
    end

    def self.destroy(id, listener)
      self.new(listener).destroy(id)
    end

    def destroy(id)
      return false unless id

      get_resource(id)
      @action = :destroy

      if destroy_resource
        listener.save_success(resource, success_message)
      else
        listener.save_failure(resource, error_message)
      end
    end

    protected
    def success_message
      "#{action} success"
    end

    def error_message
      "#{action} error"
    end

    def save_resource(params)
      false
    end

    def destroy_resource
      false
    end

    def get_resource(id=nil)
      @resource = nil
    end

    def get_resources(filters={})
      @resources = []
    end

    def action
      @action
    end

    def resource
      @resource
    end

    def resources
      @resources
    end
  end
end
