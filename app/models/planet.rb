class Planet < ActiveRecord::Base
  has_many :spaces
  before_create :create_slug
  validates :name, presence: true, uniqueness: true
  validates :slug, uniqueness: { case_sensitive: false}

  def to_param
    "#{self.slug}"
  end

  def create_slug
    self.slug = name.parameterize if !name.nil?
  end
end
