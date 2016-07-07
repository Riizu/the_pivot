class Planet < ActiveRecord::Base
  has_many :spaces
  before_create :create_slug
  validates :name, presence: true, uniqueness: true
  validates :slug, uniqueness: { case_sensitive: false}

  def to_param
    "#{self.slug}"
  end

  def toggle_active
    deactivate_dependent_spaces
    self.active = !self.active
    save
  end

  def deactivate_dependent_spaces
    self.spaces.each do |space|
      space.active = false
      space.save
    end
  end

  def create_slug
    self.slug = name.parameterize if !name.nil?
  end
end
