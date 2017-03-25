class Todo < ApplicationRecord
  belongs_to :list
  before_validation :set_default_status, on: :create
  after_update :check_status
  after_update :calc_list_doneness
  after_create :calc_list_doneness

  def set_default_status
    if self.list == List.find_by(name:"Backburner")
      self.status = "Backburner"
    else
      self.status = "Pending"
    end
    self.original_list = self.list_id
    self.vaporize = false
  end

  def check_status
    if self.status == "Delete" || self.vaporize == true
      self.delete
    else   #this section covers adding a todo to the backburner list and moving it to a dated list
      # if todo status add a todo to the backburner list by changing its list id
      if self.status == "Backburner" && self.list_id != List.find_by(name:"Backburner").id
        old_list_id = self.list.id   #save the current list id
        self.update_attributes(list_id: List.find_by(name:"Backburner").id)  #reassign the todo to the backburner list
        List.find(old_list_id).calc_doneness  #update the old list 'doneness' statistics
      end
      # a todo moving from backburner will still have a status and list id of backburner, so use the new_list date to reassign to a dated list
      if self.status == "Backburner" && self.list_id == List.find_by(name: "Backburner").id && self.new_list_date != nil
        new_date = self.new_list_date
        self.update_attributes(list_id: List.find_by(date: new_date).id, new_list_date:nil, status:"Pending")
      end
    end
  end

  def is_not_orphan?
    self.status != "Backburner"
  end

  def calc_list_doneness
    self.list.calc_doneness
  end

  def status_list
    return [
      "Pending",
      "Complete",
      "Backburner",
      "Delete"
    ]
  end
  def existing_lists
    @l = List.where.not(name: "Backburner").order('date ASC').pluck(:date)
    @l.unshift("Delete")
    @l.unshift("Choose")

  end

end
