class BookBuddyService
  def self.find_by_isbn(isbn)
    response = conn.get('/search') do |req|
      req.params = {isbn: isbn}
    end

    if response.success?
      JSON.parse(response.body, symbolize_names: true)
    else
      failure = { data: {
        id: nil,
        type: 'error',
        attributes: { title: nil,
          author: nil,
          description: nil,
          thumbnail: nil,
          isbn: nil,
          category: nil
          }
        }
      }
    end
  end

  def self.conn
    url = 'https://still-ridge-56956.herokuapp.com/'
    @conn ||= Faraday.new(url)
  end
end
