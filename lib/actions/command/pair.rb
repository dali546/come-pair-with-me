# frozen_string_literal: true

module ComePairWithMe
  module Actions
    module Command
      module Pair
        def open_modal
          p modal_response.to_json
          client.views_open(
            trigger_id: data.trigger_id,
            view: modal_response.to_json
          )
        end
        alias_method '/pair-with-me', :open_modal

        private

        def modal_response
          BlockKit::Components::SimpleModal[
            title: 'New Pairing Request',
            private_metadata: data.channel_id,
            blocks: [
              BlockKit::Components::Section[text: 'Write a brief description of who what where and why you want to pair'],
              BlockKit::Components::Divider[],
              BlockKit::Components::MultiLineInput[action_id: 'field_one', value: data.text, label: 'Pairing Description', block_id: 'pairing_message']
            ]
          ]
        end
      end
    end
  end
end
