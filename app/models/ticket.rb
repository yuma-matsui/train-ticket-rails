class Ticket < ApplicationRecord
  belongs_to :entered_gate, class_name: 'Gate', foreign_key: 'entered_gate_id'
  belongs_to :exited_gate, class_name: 'Gate', foreign_key: 'exited_gate_id', required: false
  validates :fare, presence: true, inclusion: Gate::FARES
  validates :entered_gate_id, presence: true
  validate :check_distance

  def used?
    exited_gate.present?
  end

  private

  def check_distance
    if used? && !exited_gate.exit?(self)
      errors.add(:exited_gate_id, 'では降車できません。')
    end
  end

end
