require 'slack-ruby-bot'

class JiraBot < SlackRubyBot::Bot
  match(/([a-z]+-[0-9]+)/i) do |client, data, issues|
    results = []
    tomatch = data.text
    
    # Remove links from text, since they're already links, by grabbing everything between < and >
    tomatch = tomatch.sub /(<.+>)/i, ''

    # Also remove emoji, because skin-tone-2 and similar were showing up
    tomatch = tomatch.sub /:\b\S*\b:/, ''
    
    # Now grab everything that looks like a JIRA ticket, dump it into an array, grab uniques.
    
    tomatch.scan(/([a-z]+-[0-9]+)/i) do |i,j|
    	results << 'https://ticketfly.jira.com/browse/'+i.upcase
    end
    client.say(channel: data.channel, text: results.uniq.join("\n"))
  end
end

JiraBot.run