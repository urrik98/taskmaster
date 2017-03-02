class Todo < ApplicationRecord
  belongs_to :list
  before_validation :set_default_status, on: :create
  after_update :check_status
  after_update :calc_list_doneness
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
    if self.status == "Orphan" && self.list_id == List.find_by(name: "Orphans").id && self.new_list_date != nil
      new_date = self.new_list_date
      self.update_attributes(list_id: List.find_by(date: new_date).id, new_list_date:nil, status:"Pending")
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
  def existing_lists
    @l = List.where.not(name: "Orphans").order('date ASC').pluck(:date)
    @l.unshift("Choose")
  end

end
