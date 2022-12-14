module StyleHelper
  def status_style(status)
    if status == "pending"
      "text-gray-500"
    elsif status == "declined"
      "text-red-500"
    elsif status == "accepted"
      "text-yellow-500"
    else
      "text-green-500"
    end
  end

  def admin_object_status(object)
    if object["status"] == "happened"
      "text-green-500"
    else
      "text-gray-500"
    end
  end
end
