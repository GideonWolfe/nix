{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
	xdg.configFile = {
		newsboat_urls = {
			enable = true;
			target = "newsboat/urls";
			text = ''
		
https://feeds.bbci.co.uk/news/politics/rss.xml news politics "~BBC Politics"

https://feeds.bbci.co.uk/news/business/rss.xml news business "~BBC Business"



https://feeds.bbci.co.uk/news/science_and_environment/rss.xml news science "~BBC Science and Environment"
https://www.theverge.com/rss/science/index.xml news science "~The Verge: Science"

https://feeds.bbci.co.uk/news/world/rss.xml news world "~BBC World News"

https://feeds.bbci.co.uk/news/entertainment_and_arts/rss.xml news entertainment "~BBC Entertainment"
https://billboard.com/feed news entertainment news entertainment "~Billboard"
https://pitchfork.com/feed/feed-news/rss news entertainment "~Pitchfork"

https://techcrunch.com/feed/ news technology "~Tech Crunch"
https://gizmodo.com/rss/ news technology "~Gizmodo"
https://lifehacker.com/index.xml news technology "~LifeHacker"
https://feeds.bbci.co.uk/news/technology/rss.xml news technology "~BBC Technology"
https://engadget.com/rss.xml news technology "~Engadget"
https://www.wired.com/feed/rss news technology "~Wired"
http://feeds.arstechnica.com/arstechnica/index/ news technology "~Ars Technica"
https://hackernewsrss.com/feed.xml news technology "~Hacker News"
https://hn.invades.space/hn_gems_rss.xml news technology "~Top Hacker News"

https://www.theverge.com/rss/cyber-security/index.xml news cybersecurity "~The Verge: Cybersecurity"
https://portswigger.net/research/rss news cybersecurity "~Portswigger Research"
			'';
		};
	};
}
