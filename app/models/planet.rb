class Planet < ActiveRecord::Base
  has_many :spaces
  before_create :create_slug
  validates :name, presence: true, uniqueness: true
  validates :slug, uniqueness: { case_sensitive: false}

  def to_param
    "#{self.slug}"
  end

  def toggle_active
    toggle_dependencies
    self.active = !self.active
    save
  end

  def toggle_dependencies
    self.spaces.each do |space|
      if self.active
        space.active = false
      else
        space.active = true
      end
      space.save
    end
  end

  def create_slug
    self.slug = name.parameterize if !name.nil?
  end
end
