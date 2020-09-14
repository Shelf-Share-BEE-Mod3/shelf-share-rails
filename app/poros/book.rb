# frozen_string_literal: true

class Book
  attr_reader :title, :author, :description, :thumbnail, :isbn, :category

  def initialize(attributes)
    @title = attributes[:data][:attributes][:title]
    @author = attributes[:data][:attributes][:author]
    @description = attributes[:data][:attributes][:description]
    @thumbnail = attributes[:data][:attributes][:thumbnail]
    @isbn = attributes[:data][:attributes][:isbn]
    @category = attributes[:data][:attributes][:category]
  end
end
