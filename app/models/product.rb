class Product < ActiveRecord::Base

  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_items

  validates :description, :image_url, :title, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true, length: { minimum: 10 }

  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|jpeg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }

  private

  def ensure_not_referenced_by_any_line_items
    if line_items.empty?
      return true
    else
      errors.add(:base, "Line Items present")
      return false
    end
  end
end