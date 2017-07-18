def is_between_short_time? created_at, updated_at
  if created_at.present? && updated_at.present?
    time = I18n.l self, format: :short_time
    time < I18n.l(created_at, format: :short_time) ||
      time > I18n.l(updated_at, format: :short_time)
  else
    false
  end
end
