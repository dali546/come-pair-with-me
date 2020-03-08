# frozen_string_literal: true

module BlockKit
  module Components
    Divider = lambda {
      {
        type: 'divider'
      }
    }

    Section = lambda { |text: nil|
      {
        type: 'section',
        text: {
          type: 'mrkdwn', text: text
        }
      }
    }

    TextField = lambda { |text|
      {
        type: 'plain_text',
        text: text,
        emoji: true
      }
    }

    MultiLineInput = lambda { |action_id: nil, value: nil, label: nil, block_id: nil|
      {
        type: 'input',
        element: {
          type: 'plain_text_input',
          multiline: true,
          action_id: action_id,
          initial_value: value
        },
        label: {
          type: 'plain_text',
          text: label,
          emoji: true
        },
        block_id: block_id
      }
    }

    SimpleModal = lambda { |title: nil, private_metadata: nil, blocks: []|
      {
        type: 'modal',
        private_metadata: private_metadata,
        title: BlockKit::Components::TextField[title],
        submit: BlockKit::Components::TextField['Submit'],
        close: BlockKit::Components::TextField['Cancel'],
        blocks: blocks
      }
    }

    Button = lambda { |action_id: nil, text: nil, value: nil|
      {
        type: 'button',
        action_id: action_id,
        text: BlockKit::Components::TextField[text],
        value: value
      }
    }

    Actions = lambda { |actions: []|
      {
        type: 'actions',
        elements: actions
      }
    }
  end
end
