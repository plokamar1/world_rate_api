# frozen_string_literal: true

class BaseService
  attr_reader :errors

  def initialize(*args)
    @errors = []
  end

  def call
    raise NoMethodError, "Call method must be implemented in subclass"
  end

  def success?
    !failure?
  end

  def failure?
    @errors.any?
  end

  protected

    def add_error(error)
      (@errors ||= []) << error
    end
end
