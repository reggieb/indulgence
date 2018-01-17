require_relative 'indulgence/exceptions'
require_relative 'indulgence/ability'
require_relative 'indulgence/permission'
require_relative 'indulgence/indulgent'
require_relative 'active_record/acts/indulgent'

module Indulgence
  def self.strict?
    !instance_variable_defined?(:@strict) || @strict
  end

  def self.strict=(boolean)
    @strict = boolean
  end
end
