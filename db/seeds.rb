# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
def tag(title)
  Tag.find_or_create_by_title(title)
end

def goal(title, *tags)
  unless Goal.where(:title => title).present?
    goal = Goal.create!(:title => title)
    tags.each{|tag| goal.tags << tag }
  end
end

health    = tag("health")
fitness  = tag("fitness")
addiction = tag("addiction")
running = tag("running")
learning = tag("learning")
personal_growth = tag("personal_growth")
work = tag("work")
achievement = tag("achievement")
charity = tag("charity")
sports = tag("sports")
music = tag("music")
skill = tag("skill")
entertainment = tag("entertainment")
family = tag("family")
education = tag("education")
financial = tag("financial")

goal("quit smoking", health, addiction)
goal("lose weight", health)
goal("run a marathon", health, fitness, running, achievement)
goal("run three times a week", health, fitness, running)
goal("learn to play guitar", learning, music, skill)
goal("listen better", personal_growth)
goal("learn to golf", learning, sports, fitness)
goal("help more charities", charity)
goal("write a song", music)
goal("dunk a basketball", sports, achievement, skill)
goal("be a better father", personal_growth, family)
goal("quit my job", work)
goal("start a company",  work)
goal("climb Mount Everest", achievement, fitness)
goal("perform a concert", achievement, music)
goal("get into college", achievement, education)
goal("not be so stressed", personal_growth)
goal("break a world record", achievement)
goal("learn to salsa", personal_growth, learning, fitness, skill)
goal("get over my fears", personal_growth)
goal("get a better job", work, personal_growth)
goal("not worry so much", personal_growth)
goal("be more patient", personal_growth)
goal("go to the gym more", fitness, health)
goal("save more", financial)
goal("learn Spanish", skill, learning)
goal("perform standup comedy", achievement, entertainment)
