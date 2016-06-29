class Space < ActiveRecord::Base
  belongs_to :style
  belongs_to :planet
  has_many :orders, through: :reservations
  has_many :reservations
  before_validation :create_slug
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true
  validates :style_id, presence: true
  validates :planet_id, presence: true
  has_attached_file :image_url, styles: { medium: "250x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image_url, content_type: /\Aimage\/.*\Z/

  def to_param
    "#{self.slug}"
  end

  def create_slug
    self.slug = name.parameterize if !name.nil?
  end

  def status
    if available
      "#{name.capitalize} is available"
    else
      "#{name.capitalize} is currently unavailable for purchase"
    end
  end

  def self.new_space(space_params)
    Space.new(name:          space_params[:name],
              price:        space_params[:price],
              description:  space_params[:description],
              image_url:    space_params[:image_url],
              style_id:     Style.find_by(name: space_params[:style]).id,
              planet_id:    Planet.find_by(title: space_params[:planet]).id,
            )
  end

  def update_space(space_params)
    update(name:          space_params[:name],
            price:        space_params[:price],
            description:  space_params[:description],
            image_url:    space_params[:image_url],
            style_id:     Style.find_by(name: space_params[:style]).id,
            category_id:  Planet.find_by(title: space_params[:planet]).id,
          )
  end
end
