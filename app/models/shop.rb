class Shop < ApplicationRecord
  has_many :orders
  has_many :order_products, through: :orders
  has_many :products

  scope :by_shop, -> shop_id {where id: shop_id if shop_id.present?}

  def is_owner? user
    owner == user
  end

  def all_tags
    tags.uniq
  end

  def get_shop_manager_by user
    shop_managers.by_user(user).first
  end

  private
  def create_shop_manager
    shop_managers.create user_id: owner_id
  end

  def image_size
    max_size = Settings.pictures.max_size
    if cover_image.size > max_size.megabytes
      errors.add :cover_image,
        I18n.t("pictures.error_message", max_size: max_size)
    end
    if avatar.size > max_size.megabytes
      errors.add :avatar, I18n.t("pictures.error_message", max_size: max_size)
    end
  end

  def send_notification_after_requested
    ShopNotification.new(self).send_when_requested
  end

  def send_notification_after_confirmed
    if self.status_changed? && !self.pending?
      ShopNotification.new(self).send_when_confirmed
    end
  end

  def send_notification
    if self.status_changed? && !self.pending?
      Event.create message: self.status, user_id: owner_id,
        eventable_id: id, eventable_type: Shop.name
    end
  end
end
