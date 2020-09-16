class BorrowRequestPoro
  attr_reader :id, :book_title, :belongs_to, :borrower
  def initialize(params)
    @id = params[:id]
    @book_title = params[:book_title]
    @belongs_to = params[:belongs_to]
    @borrower = params[:borrower]
  end
end
