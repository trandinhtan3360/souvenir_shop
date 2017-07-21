module ApplicationHelper
  def full_title page_title
    base_title = t ".title_website"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def admin_full_title page_title
    base_title = I18n.t "common.admin_title"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def increase_one index
    index + Settings.order_increase
  end

  def compare_time_order start_hour, end_hour
    start_hour < end_hour
  end


  def count_notification_unread
    if user_signed_in?
      number_noti =  @count_unread_notification
      if number_noti == Settings.notification.number_unread_not_display
        number_noti = ""
      else
        number_noti
      end
    end
  end

  def total_price price, quantity
    price * quantity
  end

  def format_price price
    price.to_i.to_s + t("cart.vnd")
  end

  def bg_unread event
    if event.read == false
      "unread"
    end
  end

  def detail_price cart
    @cart_price = 0
    cart.each do |item|
      @cart_price += item.total_price
    end
    @cart_price
  end

  def selected_lang
    session[:locale]
  end
end
