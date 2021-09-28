---
title: "My adventure providing thousands of people with current information on COVID19"
Tags: ["Covid-19", "Python", "Open Data"]
date: 2021-09-29T09:00:12+01:00
---
Since December, I run a multi-platform messenger bot that provides information about the COVID-19 pandemic in Germany.
It did start as a small project I built for a friend of mine, and quickly expanded to a service used by several thousand people daily and backed by a big German political association called [D-64](https://d-64.org/).
At peak times, the bot reached out to more than 10,000 users, which scared me at the moment.
Now, everything is a bit more relaxed and as I am less involved, I'd like to tell the story and write up my experience.

But first, a short overview:
The bot provides current personalized statistics related to the pandemic via Telegram, Signal, Threema, Facebook Messenger, Twitter, Mastodon and Instagram.
As the rules in Germany are different in every state due to the federal system and most of them are or were dependent on the current number of cases, this was really relevant information.
So a user can subscribe to a number of districts and gets every morning a report containing the most relevant information for those with additional visualizations.
By now, those statistics comprise incidence, number of cases and deaths, information about the capacity of the local ICU and hospital, vaccination information and local rules.
The bot is open-source on [Github](https://github.com/eknoes/covidbot/) and if you'd like to give it a try go to its german [website](https://covidbot.d-64.org/).
You can find an exemplary screencast at the bottom of this entry.

Read more to hear about the story behind the whole project, its technical basis and my learnings from such a project.
<!-- more -->

# How it started
Everything started with a call from a close friend around Christmas 2020: He used to live in a region in Germany that provided current COVID19 statistics for its citizens via Telegram.
After moving to somewhere else, he asked if I would be able to build a small Telegram bot that just sends the current 7-day-incidence---which is the number of infections per 100,000 citizens during the last 7 days---to his phone.
Taking a look at this idea just before Christmas, I quickly built a simple prototype that would just do that, but nothing else.
As the official German agency for disease control---the Robert Koch Institute (RKI)---provides some of its statistics as open data and the Telegram Bot API is quite simple, that was an easy task.

But after some time, some friends and family was using it too, and requested more features:
Graphics, visualizing the whole situation.
Support for other messengers, such as Threema and Signal.
Current rules for their cities and states.
Other metrics, such as the current capacity of the ICUs or the numbers of daily vaccinations.
As I am far from being a professional software developer, a good server admin or an expert for UX/UI (which is especially complicated for a complex messenger bot), this were challenging and time consuming tasks for me: I am a computer science student currently enrolled in a demanding master programme for cybersecurity.
But constant feedback from happy users encouraged me to improve the bot, add metrics, fix bugs, etc.
Furthermore, my friend who initially had the idea did a great job on user support, fixing smaller bugs and discovering new data sources.

Then, [D-64](https://d-64.org) wanted to support our project.
This is a big political association in Germany, fighting for digital progress, open source and open data.
At first, I was not sure if I liked this, but after some days I happily accepted it: They pay the server, take some responsibility for the project and could use their contacts to get access to not-really open data.
After some time, we were mentioned on Twitter and our user numbers exploded (from ~100 to ~2000 in two days).
I was worried that this would break our small server @ [Uberspace](https://uberspace.de/en/), but somehow it worked.
Furthermore, the local newspaper [interviewed me](https://www.echo-online.de/lokales/darmstadt/darmstadter-entwickelt-corona-bot_23598548) about the bot, which increased our number of users even further, so that we head around 10,000 daily users at peak times.

# Problems
Retrospective, some time was horrible in the first months: We did not really check the published statistics for consistency in the beginning, but just read them into our database and sent them to all our users.
Usually, the data was updated around 4am---spoiler alert: I am usually not awake at this time of the day---, so when we processed flawed data I was not able to withdraw them immedeatly.
Instead, I woke up and after taking a look on my phone I read dozens of messages from uncertain users, questioning the false number of cases.
As this was really relevant information for lots of people, I felt quite responsible which usually led to some anxious nights with just little sleep in the nights after such incidents.
Fortunately, after some time I was able to distance myself from the project to a healthy degree.

But there were also other issues:
As I am not an expert in software development or architecture and the bot got new features or messengers all the time, the codebase was somehow messy which led to errors.
In addition to that, especially in the beginning I was too focused on implementing more stuff, that it lacks tests and documentation---which also led to having rarely any other developers submitting PRs.
There were also issues with the open data sources: At some point in time, they changed there format or location, which obviously led to parsing errors, or some sources were not really machine readable at all.
This led to implementing metrics into the application with Prometheus, so that we could get an overview over e.g. the RAM and CPU usage and got notified on errors.
But all in all I learned a lot from it, and after having a low some nice user feedback usually encouraged me to carry on.

# Technical Basis
As there is currently no multi-messenger library in Python available, this bot is built on top of [a lot third party libraries](https://github.com/eknoes/covidbot/wiki/Credits#open-source-bibliotheken).
The support for Signal was the most challenging, as it does not support chatbots on its platform.
But by using [signald](https://gitlab.com/signald/signald) and [semaphore](https://github.com/lwesterhof/semaphore) it somehow worked, despite being it the most unstable of our platforms.
For some platforms it felt easier to implement their API into my own library (see e.g. [facebook-messenger](https://github.com/eknoes/simple-fbmessenger)) or I had to use [my own fork](https://github.com/eknoes/Mastodon.py/), as some necessary patches were not implemented.

In the beginning, everything worked on a [Uberspace](https://uberspace.de/en/), now it runs on a small vServer from Hetzner with 4GB RAM.
Also, the database evolved from a simple JSON file to MySQL.

# Future
I did not do a lot in the last months, as I had to catch up on university and am now focused on my master thesis.
There is still a lot of users and we get regular feedback and feature requests.
If the pandemic should gain traction again in fall and winter, I surely would try to have the project up-to-date with current information.
But I think this project is one of the few projects, were the founder would actually be happy if it becomes irrelevant.

Things I'd love to do despite the pandemic ending or not is to extract the messenger basis to a working multi-messenger chatbot library.

Thanks for reading, I am somehow glad to get this story of my chest.

# Screenshots & Videos
