class Dealbook::CLI 

  def call
    list_headlines
    menu
  end

  def list_headlines
    puts "Dealbook Headlines:"
    @articles = Dealbook::Article.articles
    @articles.each.with_index(1) do |article, i|
      puts "#{i}. #{article.title}"
    end
  end

  def menu
    input = nil
    while input != "exit"
      puts "Enter the number of an article or exit"
      input = gets.strip.downcase

      if input.to_i > 0
        the_article = @articles[input.to_i-1]
        puts "---------------------------"
        puts "\n#{the_article.title}:\n\n#{the_article.description}\n\n"
        puts "---------------------------"
      elsif input == "list"
        list_headlines
      else
        puts "Not sure what you want, type list or exit."
      end
    end
  end

end