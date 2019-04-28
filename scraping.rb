require 'mechanize'

agent = Mechanize.new
# target URL
page = agent.get("https://sample.url.xxxxxxx")
# css selector
elements = page.search('css selector')

# display
elements.each do |ele|
  puts ele.inner_text
end