class Book

  attr_reader :title, :author, :description, :thumbnail, :isbn

  def initialize(attributes)
    @title = attributes[:items].first[:volumeInfo][:title]
    @author = attributes[:items].first[:volumeInfo][:authors].first
    @description = attributes[:items].first[:volumeInfo][:description]
    @thumbnail = attributes[:items].first[:volumeInfo][:imageLinks][:thumbnail]
    @isbn = attributes[:items].first[:volumeInfo][:industryIdentifiers].find do |e|
      e[:type] == "ISBN_13"
    end[:identifier]
  end
end
