class Product < ApplicationRecord

  def slug_candidates
    [:name, [:name, :id]]
  end

  def should_generate_new_friendly_id?
    slug.blank? || name_changed? || super
  end

  has_many :comments, as: :commentable
  has_many :orders, through: :order_products

  private
  def image_size
    max_size = Settings.pictures.max_size
    if image.size > max_size.megabytes
      errors.add :image, I18n.t("pictures.error_message", max_size: max_size)
    end
  end

  def start_hour_before_end_hour
    unless self
      if start_hour > end_hour
        errors.add :start_hour, I18n.t("error_message_time")
      end
    end
  end
end
