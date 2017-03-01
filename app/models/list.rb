class List < ApplicationRecord
  has_many :todos
  validates_uniqueness_of :date
  validates_presence_of :date, if: :not_orphan_list?
  validates_uniqueness_of :name
  validates_presence_of :name
  before_validation :set_default_doneness, on: [:create]

  def calc_doneness
    done = BigDecimal.new(self.todos.where(status:"Complete").count)
    total = BigDecimal.new(self.todos.count)
    perc = done/total
    self.update_attributes(completed:perc)
  end

  def not_orphan_list?
    self.name != "Orphans"
  end

  def set_default_doneness
    self.completed = 0
  end
end
