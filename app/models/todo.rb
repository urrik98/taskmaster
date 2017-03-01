class Todo < ApplicationRecord
  belongs_to :list
  before_validation :set_default_status, on: :create
  after_update :check_status
  after_update :calc_list_doneness, if: :is_not_orphan?
  after_create :calc_list_doneness

  def set_default_status
    self.status = "Pending"
    self.original_list = self.list_id
  end

  def check_status
    if self.status == "Delete"
      self.delete
    end
    if self.status == "Orphan" && self.list_id != List.find_by(name:"Orphans").id
      self.update_attributes(list_id: List.find_by(name:"Orphans").id)
    end
  end

  def is_not_orphan?
    self.status != "Orphan"
  end

  def calc_list_doneness
    self.list.calc_doneness
  end

  def status_list
    return [
      "Pending",
      "Complete",
      "Orphan",
      "Delete"
    ]
  end

end
