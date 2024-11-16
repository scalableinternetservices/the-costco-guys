module ApplicationHelper
  def format_pst_time(time)
    time.in_time_zone('Pacific Time (US & Canada)').strftime("%B %d, %Y at %I:%M %p %Z")
  end
end
