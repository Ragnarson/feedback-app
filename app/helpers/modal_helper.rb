module ModalHelper
  def link_to_modal(text, modal_id, class_model, recipient_id, **options, &block)
    return if class_model.where(user: current_user, recipient: recipient_id).any?

    content_tag(:button, text, onclick: "toggleModal(#{modal_id.to_json}, event)", **options, &block)
  end
end
