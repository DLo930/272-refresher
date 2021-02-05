class Chore < ApplicationRecord
  belongs_to :child
  belongs_to :task

  validates_presence_of :due_on
  validates_date :due_on

  scope :by_task, -> { joins(:task).order("name") }
  scope :chronological, -> { order("due_on, completed") }
  scope :pending, -> { where(completed: false) }
  scope :done, -> { where(completed: true) }
  scope :upcoming, -> { where('due_on >= ?', Date.current) }
  scope :past, -> { where('due_on < ?', Date.current) }

  def status
    self.completed ? 'Completed' : 'Pending'
  end
end
