module ModalHelper
  def link_to_modal(text, modal_id, **options, &block)
    # binding.remote_pry
    content_tag(:button, text, onclick: "toggleModal(#{modal_id.to_json}, event)", **options, &block)
  end
end
