module ApplicationHelper
  def is_mobile?
    request.env["HTTP_USER_AGENT"][/mobile/i]
  end
end
