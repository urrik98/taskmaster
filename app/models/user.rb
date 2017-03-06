class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :role
  has_many :lists
  validates_presence_of :name
  before_save :assign_role
  after_create :create_unassigned_todos_list

  def assign_role
    self.role = Role.find_by name: "Regular" if self.role.nil?
  end

  def admin?
    self.role && self.role.name == "Admin"
  end

  def create_unassigned_todos_list
    self.lists.create(name:"Orphans")
  end
end
