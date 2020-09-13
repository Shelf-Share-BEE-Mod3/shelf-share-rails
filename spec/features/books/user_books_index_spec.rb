require 'rails_helper'

RSpec.describe 'User Book Index Page' do
  before :each do
    login_as_user
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
    @book = Book.new(book_attrs)
  end

  it 'My books show up on the shelf' do
    UserBook.create({
      user_id: current_user.id,
      isbn: @book.isbn,
      status: 'available'
      })
    UserBook.create({
      user_id: current_user.id,
      isbn: "123456789",
      status: 'unavailable'
      })
    visit 'user/books'
    expect(page).to have_content(@book.isbn)
  end
end
