class Parser
    require 'set'
    @@bookcsv_path = Rails.root.join('app', 'assets', 'book.csv')

    def self.get_unique_authors
        unique_authors = Set.new
        File.foreach(@@bookcsv_path) do |line|
            authors = line.split(',')[2]
            authors.split('/').each do |author|
                unique_authors.add(author.strip)
            end
        end
        unique_authors
    end

    def self.seed_authors
        authors = get_unique_authors
        authors.each do |author|
            Author.create(name: author)
        end
    end

    def self.seed_publishers
        publishers = get_unique_publishers
        publishers.each do |publisher|
            Publisher.create(name: publisher)
        end
    end

    def self.get_unique_publishers
        unique_publishers = Set.new
        File.foreach(@@bookcsv_path) do |line|
            publisher = line.split(',')[11]
            unique_publishers.add(publisher.strip)
        end
        unique_publishers
    end

    def self.seed_books
        File.foreach(@@bookcsv_path) do |line|
            line = line.split(',')
            title = line[1]
            authors = line[2].split('/')
            average_rating = multiply_average_rating_by_100(line[3])
            isbn = line[4]
            isbn13 = line[5]
            language = line[6]
            num_page = line[7].to_i
            ratings_count = line[8].to_i
            text_review_count = line[9].to_i
            publication = line[10]
            publisher = line[11]
            
            book = Book.create(
                title: title,
                average_rating: average_rating,
                isbn: isbn,
                isbn13: isbn13,
                language: language,
                num_page: num_page,
                ratings_count: ratings_count,
                text_review_count: text_review_count,
                publisher_id: get_publisher_id(publisher)
            )

            if has_multiple_authors?(authors)
                authors[0..].each do |author|
                    BookAuthor.create(book_id: book.id, author_id: get_author_id(author))
                end
            end
        end
    end

    def self.has_multiple_authors?(authors)
        authors.size > 1
    end

    def self.get_publisher_id(publisher)
        Publisher.find_by(name: publisher.strip).id
    end

    def self.get_author_id(author)
        Author.find_by(name: author).id
    end

    def self.remove_decimals(num)
        num.split('.').join
    end

    def self.multiply_average_rating_by_100(average_rating)
        average_rating = remove_decimals(average_rating)
        while average_rating.size < 3
            average_rating = average_rating + '0'
        end
        average_rating.to_i
    end
end