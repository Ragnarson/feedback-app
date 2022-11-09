module StyleHelper
  def status_style(status)
    if status == "pending"
      "text-gray-500"
    elsif status == "declined"
      "text-red-500"
    else
      "text-green-500"
    end
  end
end
