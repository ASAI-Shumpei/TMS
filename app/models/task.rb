class Task < ApplicationRecord
  enum :status, { pending: 0, in_progress: 1, completed: 2, archived: 3 }
  validates :subject, presence: true
  validates :detail, length: { maximum: 300 }, allow_blank: true
  validates :due_date, presence: true
  validate :due_date_cannot_be_in_the_past
  validates :status,presence: true
  private

  def due_date_cannot_be_in_the_past
    if due_date.present? && due_date < Time.zone.now
      errors.add(:due_date, "は過去に設定できません")
    end
  end
end