class Dealbook::Article
  attr_accessor :title, :description, :link


  def self.articles
    url = "http://www.nytimes.com/pages/business/dealbook/index.html"
    page = Nokogiri::HTML(open(url))
    doc = page.css(".aColumn .columnGroup")
    articles = []
    self.get_header(doc, articles)
    self.get_others(doc, articles)
    articles
  end

  def self.get_header(doc, articles)
    a = self.new
    a.title = doc.search(".storyHeader h2").text.gsub(/\n/,"")
    a.description = doc.search(".ledeStory .summary").text.gsub(/\n/,"")
    a.link = doc.search(".storyHeader h2 a").attribute("href").value
    articles << a
  end

  def self.get_others(doc, articles)
    doc.search(".story").each do |story|
      a = self.new
      a.title = story.search("h3 a").text.gsub(/\n/,"")
      a.description = story.search(".summary").text.gsub(/\n/,"")
      a.link = story.search("h3 a").attribute("href").value
      articles << a
    end
  end

end

# da = Dealbook::Article.new