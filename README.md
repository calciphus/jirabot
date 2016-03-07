# Jirabot
A Slack bot that watches any channel it's invited to for mentions of JIRA issues. If it sees one, it responds with a message consisting of:

	ISSUE-1223: Issue summary
	https://yourlocation.jira.com/browse/ISSUE-1223
	Issue Status (Issue Type)

## Setup
You'll need to configure a bot on Slack (fixme: Add setup link) and get your API token. Once you have that, set a new environmental variable `SLACK_API_TOKEN`. Additionally, you'll need to supply JIRA credentials and your JIRA enpoint address. This is because JIRA cloud doesn't support app tokens. Yeah, in 2016 you have to use basic auth if your app doesn't run through a browser.

For local development, you can do this with a `.env` file, which we've helpfully left out of this repo.

    # ENV Sample
    SLACK_API_TOKEN=yourtokengoeshere
    JIRA_USER=jirauser_notemail
    JIRA_PASS=jirapassword
    JIRA_PREFIX=https://yourcompany.jira.com/

## Running Locally

    foreman start

This will open your connection to the Slack API, and your bot will be online. You can connect to it and chat with it directly (it'll behave the same way).