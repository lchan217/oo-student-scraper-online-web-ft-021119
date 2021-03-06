require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    main = doc.css('.student-card')
    array_of_hashes = [] 
    main.map do |person|
       array_of_hashes << {:name => person.css('.card-text-container').css('.student-name').text, 
        :location =>  person.css('.card-text-container').css('.student-location').text, 
        :profile_url => person.css('a[href^="students/"]').first.values.join
        }
    end
    array_of_hashes
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
   
    
    nodes = doc.css('.social-icon-container').css('a[href]')
    student_hash = {}
    nodes.each do |x|
   
      if x.first.join.include?('twitter')

        student_hash[:twitter] = x.first[1]
        elsif x.first.join.include?('linkedin')
        student_hash[:linkedin] = x.first[1]
        elsif x.first.join.include?('github')
        student_hash[:github] = x.first[1]
        elsif !(x.first.join.include?('#'))
        student_hash[:blog] = x.first[1]
      end
    end 
    student_hash[:profile_quote] = doc.css('.profile-quote').text
    
    student_hash[:bio] = doc.css("div.bio-content p").text
    student_hash
  end

end

#3/5 office hours
 #   if main.css('a[href*="twitter"]').first != nil
    #     student_hash[:twitter] =  main.css('a[href*="twitter"]').first.values.join
    #   end
    #   if main.css('a[href*="linkedin"]').first != nil
    #     student_hash[:linkedin] = main.css('a[href*="linkedin"]').first.values.join
    #   end
    #   if main.css('a[href*="github"]').first != nil
    #     student_hash[:github] = main.css('a[href*="github"]').first.values.join
    #   end
    #   if main.css('a[href]')[].values != "#" 
    #     student_hash[:blog] = main.css('a[href]')[-1].values.join
    #   end

