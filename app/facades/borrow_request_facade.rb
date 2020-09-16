class BorrowRequestFacade
  def self.incoming_book_borrow_requests(user)
    user.incoming_book_borrow_requests.map do |request|
        # BorrowRequestPoro.new(request)
        require "pry"; binding.pry
    end
  end

end
