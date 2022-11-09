module StyleHelper
  def status_style(status)
    if status == "pending"
      "text-gray-500"
    elsif status == "accepted"
      "text-green-500"
    else
      "text-sm text-red-500"
    end
  end
end
