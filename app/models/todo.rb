class Todo < ApplicationRecord
  belongs_to :list
  before_validation :set_default_status, on: :create
  after_update :check_status
  after_update :calc_list_doneness

  def set_default_status
    self.status = "Pending"
  end

  def check_status
    if self.status == "Delete"
      self.delete
    end
  end

  def calc_list_doneness
    self.list.calc_doneness
  end

  def status_list
    return [
      "Pending",
      "Complete",
      "Delete"
    ]
  end

end
