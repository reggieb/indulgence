require 'indulgence'
class WorkProcess < ActiveRecord::Base
  
  def indulge?(user, ability)
    permission = WorkProcessPermission.new(user, ability, stage)
    permission.compare_single self
  end

  def self.indulgence(user, ability, stage_name)
    permission = WorkProcessPermission.new(user, ability, stage_name)
    permission.filter_many(self).where(:stage => stage_name)

  rescue Indulgence::NotFoundError, Indulgence::AbilityNotFound
    raise ActiveRecord::RecordNotFound.new('Unable to find the item(s) you were looking for')
  end

end
