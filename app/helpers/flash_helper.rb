module FlashHelper
  class << self
    def next_flash_index
      @id ||= 0
      @id += 1
    end
  end

  def each_flash_with_unique_index
    flash&.each do |(type, message)|
      yield type, message, FlashHelper.next_flash_index
    end
  end

  def flash_container_classes(type)
    base_classes = "max-w-sm w-full flex pointer-events-auto shadow rounded-md p-4 overflow-hidden"
    color_classes = case type.to_sym
    when :notice then "bg-green-50"
    when :alert then "bg-red-50"
    else "bg-yellow-50"
    end

    "#{base_classes} #{color_classes}"
  end

  def flash_message_classes(type)
    base_classes = "text-sm font-medium"
    color_classes = case type.to_sym
    when :notice then "text-green-800"
    when :alert then "text-red-800"
    else "text-yellow-800"
    end

    "#{base_classes} #{color_classes}"
  end

  def flash_message_details_classes(type)
    base_classes = "list-disc pl-6 mt-2"
    color_classes = case type.to_sym
    when :notice then "text-green-600"
    when :alert then "text-red-600"
    else "text-yellow-600"
    end

    "#{base_classes} #{color_classes}"
  end

  def flash_exit_button_classes(type)
    base_classes = "inline-flex rounded-md p-1.5 focus:outline-none focus:ring-2 focus:ring-offset-2"
    color_classes = case type.to_sym
    when :notice
      "bg-green-50 text-green-500 hover:bg-green-100 focus:ring-offset-green-50 focus:ring-green-400"
    when :alert
      "bg-red-50 text-red-500 hover:bg-red-100 focus:ring-offset-red-50 focus:ring-red-400"
    else
      "bg-yellow-50 text-yellow-500 hover:bg-yellow-100 focus:ring-offset-yellow-50 focus:ring-yellow-400"
    end

    "#{base_classes} #{color_classes}"
  end

  def flash_svg(type)
    render("shared/svg/" + case type.to_sym
           when :notice then "success"
           when :alert then "error"
           else "attention"
           end)
  end

  def flash_hidden(message)
    message.empty? ? "hidden" : ""
  end

  def flash_auto_hide_script(index, timeout: 5000)
    %(
      setTimeout(() => {
        const flash = document.getElementById("flash-#{index}");
        if (flash) flash.remove();
      }, #{timeout});
    )
  end
end
