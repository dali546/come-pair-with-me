# frozen_string_literal: true

class InviteController < ApplicationController
  def index
    render html: helpers.tag.a(
      helpers.tag.img(
        alt: 'Add to Slack', height: 40, width: 139, src: img_src
      ),
      href: "#{base_uri}scope=#{scope}&client_id=#{ENV['SLACK_CLIENT_ID']}"
    )
  end

  private

  def base_uri
    'https://slack.com/oauth/v2/authorize?'
  end

  def scope
    %w[app_mentions:read channels:join channels:read chat:write commands
       groups:history groups:read groups:write im:history im:read im:write
       mpim:read channels:manage channels:history emoji:read mpim:history
       mpim:write team:read users:read users:write&user_scope=channels:read
       chat:write groups:history groups:read groups:write identify im:history
       im:read im:write mpim:history mpim:read mpim:write users:read
       users:write usergroups:read channels:write channels:history calls:read
       calls:write].join(',')
  end

  def img_src
    'https://platform.slack-edge.com/img/add_to_slack.png'
  end
end
