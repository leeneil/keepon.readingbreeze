# encoding=utf-8 
require "open-uri"
require "json"

pat1 = /<img class="media-object" src="(https:\/\/www.keepon.com.tw\/UploadFile\/\w+\/\w+\/\w+\/([\w\-]+\.[jpn]{2}g))" width="100" height="100" alt="image">/
pat2 = /https:\/\/www.keepon.com.tw\/UploadFile\/\w+\/\w+\/\w+\/([\w\-]+\.png)/

html = open("raw.html").read
urls = html.scan(pat1).to_a

unless Dir.exists?("images/")
    Dir.mkdir("images/")
end


for url in urls
	puts "fetching " + url[0] 
	filename = url[1]
	unless File.exists?("images/" + filename)
		open("images/" + filename, 'wb') do |file|
			puts "saving " + filename
	        file << open(url[0].to_s).read
	    end
	end
end