class BorrowRequestPoro
  attr_reader :book_title, :belongs_to, :borrower
  def initialize(params)
    @book_title = params[:book_title]
    @belongs_to = params[:belongs_to]
    @borrower = params[:borrower]
  end
end
