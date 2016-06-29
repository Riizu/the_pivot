class Space < ActiveRecord::Base
  belongs_to :style
  belongs_to :planet
  has_many :orders, through: :order_items
  has_many :order_items
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
  validates :style_id, presence: true
  validates :planet_id, presence: true
  has_attached_file :image_url, styles: { medium: "250x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image_url, content_type: /\Aimage\/.*\Z/

  def status
    if retired
      "#{name.capitalize} is retired"
    else
      "#{name.capitalize} is currently available for purchase"
    end
  end

  def self.new_sock(sock_params)
    Sock.new(name:          sock_params[:name],
              price:        sock_params[:price],
              image_url:    sock_params[:image_url],
              style_id:     Style.find_by(name: sock_params[:style]).id,
              planet_id:    Planet.find_by(title: sock_params[:planet]).id)
  end

  def update_sock(sock_params)
    update(name:          sock_params[:name],
            price:        sock_params[:price],
            foot:         sock_params[:foot],
            image_url:    sock_params[:image_url],
            style_id:     Style.find_by(name: sock_params[:style]).id,
            planet_id:    Planet.find_by(title: sock_params[:planet]).id)
  end
end
