module ModalHelper
  def link_to_modal(text, modal_id, class_model_1, class_model_2=nil, recipient_id, **options, &block)
    if class_model_2.present?
      return if class_model_2.where(user: current_user, recipient: recipient_id).any?
    end
    return if class_model_1.where(user: current_user, recipient: recipient_id).any?

    content_tag(:button, text, onclick: "toggleModal(#{modal_id.to_json}, event)", **options, &block)
  end
end
