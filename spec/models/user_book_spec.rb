require 'rails_helper'

RSpec.describe UserBook, type: :model do
  describe 'validations' do
    it { should validate_presence_of :status }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :isbn }
  end

  describe 'relationships' do
    it { should belong_to :user}
  end

  describe 'class methods' do
    before :each do
      api_call = {
      "kind": "books#volumes",
      "totalItems": 1,
      "items": [
        {
          "kind": "books#volume",
          "id": "WEW1cC7yaCQC",
          "etag": "LN8exKcLrq4",
          "selfLink": "https://www.googleapis.com/books/v1/volumes/WEW1cC7yaCQC",
          "volumeInfo": {
            "title": "Ender's Game",
            "authors": [
              "Orson Scott Card"
            ],
            "publisher": "St. Martin's Press",
            "publishedDate": "2013-10",
            "description": "An expert at simulated war games, Andrew \"Ender\" Wiggin believes that he is engaged in one more computer war game when, in truth, he is commanding the last Earth fleet against an alien race seeking Earth's complete destruction.",
            "industryIdentifiers": [
              {
                "type": "ISBN_10",
                "identifier": "076537062X"
              },
              {
                "type": "ISBN_13",
                "identifier": "9780765370624"
              }
            ],
            "readingModes": {
              "text": false,
              "image": false
            },
            "pageCount": 324,
            "printType": "BOOK",
            "categories": [
              "Fiction"
            ],
            "averageRating": 4,
            "ratingsCount": 679,
            "maturityRating": "NOT_MATURE",
            "allowAnonLogging": false,
            "contentVersion": "0.8.3.0.preview.0",
            "panelizationSummary": {
              "containsEpubBubbles": false,
              "containsImageBubbles": false
            },
            "imageLinks": {
              "smallThumbnail": "http://books.google.com/books/content?id=WEW1cC7yaCQC&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
              "thumbnail": "http://books.google.com/books/content?id=WEW1cC7yaCQC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
            },
            "language": "en",
            "previewLink": "http://books.google.com/books?id=WEW1cC7yaCQC&printsec=frontcover&dq=isbn:9780765370624&hl=&cd=1&source=gbs_api",
            "infoLink": "http://books.google.com/books?id=WEW1cC7yaCQC&dq=isbn:9780765370624&hl=&source=gbs_api",
            "canonicalVolumeLink": "https://books.google.com/books/about/Ender_s_Game.html?hl=&id=WEW1cC7yaCQC"
          },
          "saleInfo": {
            "country": "US",
            "saleability": "NOT_FOR_SALE",
            "isEbook": false
          },
          "accessInfo": {
            "country": "US",
            "viewability": "PARTIAL",
            "embeddable": true,
            "publicDomain": false,
            "textToSpeechPermission": "ALLOWED",
            "epub": {
              "isAvailable": false
            },
            "pdf": {
              "isAvailable": false
            },
            "webReaderLink": "http://play.google.com/books/reader?id=WEW1cC7yaCQC&hl=&printsec=frontcover&source=gbs_api",
            "accessViewStatus": "SAMPLE",
            "quoteSharingAllowed": false
          },
          "searchInfo": {
            "textSnippet": "An expert at simulated war games, Andrew &quot;Ender&quot; Wiggin believes that he is engaged in one more computer war game when, in truth, he is commanding the last Earth fleet against an alien race seeking Earth&#39;s complete destruction."
          }
        }
      ]
      }
      json_call = api_call.to_json
      book_attrs = JSON.parse(json_call, symbolize_names: true)
      @book1 = Book.new(book_attrs)

      api_call2 = {
      "kind": "books#volumes",
      "totalItems": 1,
      "items": [
        {
          "kind": "books#volume",
          "id": "WEW1cC7yaCQC",
          "etag": "LN8exKcLrq4",
          "selfLink": "https://www.googleapis.com/books/v1/volumes/WEW1cC7yaCQC",
          "volumeInfo": {
            "title": "Test Book",
            "authors": [
              "Test Author"
            ],
            "publisher": "St. Martin's Press",
            "publishedDate": "2013-10",
            "description": "Book description test",
            "industryIdentifiers": [
              {
                "type": "ISBN_10",
                "identifier": "076537062X"
              },
              {
                "type": "ISBN_13",
                "identifier": "1234567890123"
              }
            ],
            "readingModes": {
              "text": false,
              "image": false
            },
            "pageCount": 324,
            "printType": "BOOK",
            "categories": [
              "Fiction"
            ],
            "averageRating": 4,
            "ratingsCount": 679,
            "maturityRating": "NOT_MATURE",
            "allowAnonLogging": false,
            "contentVersion": "0.8.3.0.preview.0",
            "panelizationSummary": {
              "containsEpubBubbles": false,
              "containsImageBubbles": false
            },
            "imageLinks": {
              "smallThumbnail": "http://books.google.com/books/content?id=WEW1cC7yaCQC&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
              "thumbnail": "http://books.google.com/books/content?id=WEW1cC7yaCQC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
            },
            "language": "en",
            "previewLink": "http://books.google.com/books?id=WEW1cC7yaCQC&printsec=frontcover&dq=isbn:9780765370624&hl=&cd=1&source=gbs_api",
            "infoLink": "http://books.google.com/books?id=WEW1cC7yaCQC&dq=isbn:9780765370624&hl=&source=gbs_api",
            "canonicalVolumeLink": "https://books.google.com/books/about/Ender_s_Game.html?hl=&id=WEW1cC7yaCQC"
          },
          "saleInfo": {
            "country": "US",
            "saleability": "NOT_FOR_SALE",
            "isEbook": false
          },
          "accessInfo": {
            "country": "US",
            "viewability": "PARTIAL",
            "embeddable": true,
            "publicDomain": false,
            "textToSpeechPermission": "ALLOWED",
            "epub": {
              "isAvailable": false
            },
            "pdf": {
              "isAvailable": false
            },
            "webReaderLink": "http://play.google.com/books/reader?id=WEW1cC7yaCQC&hl=&printsec=frontcover&source=gbs_api",
            "accessViewStatus": "SAMPLE",
            "quoteSharingAllowed": false
          },
          "searchInfo": {
            "textSnippet": "An expert at simulated war games, Andrew &quot;Ender&quot; Wiggin believes that he is engaged in one more computer war game when, in truth, he is commanding the last Earth fleet against an alien race seeking Earth&#39;s complete destruction."
          }
        }
      ]
      }
      json_call2 = api_call2.to_json
      book_attrs2 = JSON.parse(json_call2, symbolize_names: true)
      @book2 = Book.new(book_attrs2)
      @user = User.create(id: 1)
      @ub1 = UserBook.create({
        user_id: @user.id,
        isbn: @book1.isbn,
        status: "available"
        })
      @ub2 = UserBook.create({
        user_id: @user.id,
        isbn: @book2.isbn,
        status: "unavailable"
        })
    end

    it "find_available_books" do
      expect(UserBook.find_available_books).to eq([@ub1])
    end

    it "find_unavailable_books" do
      expect(UserBook.find_unavailable_books).to eq([@ub2])
    end
  end
end
