require "rails_helper"

RSpec.describe "Borrowing Without Address Sad Path / Edge Case" do
  before :each do
    @librarian = create(:librarian)
    create(:address, user: @librarian)
    @book = create(:book)
    @library_book = create(:user_book, user: @librarian, book: @book)

    @borrower = create(:borrower)
    # borrower has no address
    # create(:address, user: @borrower)
    @librarian.friends << @borrower
    @borrower.friends << @librarian
  end

  describe "librarian approves book request when borrower has no address" do
    it "They get a flash error message and the request is declined" do
      borrow_request = create(:request, borrower: @borrower, user_book: @library_book)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@librarian)
      visit borrow_index_path
      within ".incoming-pending-requests" do
        click_button "Approve"
      end

      expect(current_path).to eq(user_dashboard_path)
      message = "Oops! #{@borrower.full_name} somehow made a request without submitting an address. " +
                "This request has been declined and #{@book.title} is still available for borrowing."
      expect(page).to have_content(message)
      borrow_request.reload
      expect(borrow_request.status).to eq("declined")
      expect(@library_book.status).to eq("available")
    end
  end

  describe "borrower will be prompted to add address before borrowing a book" do
    it "They will be redirected to the new address form instead" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@borrower)
      visit books_path
      click_link @book.title
      expect do
        click_button "Ask to Borrow"
      end.to_not change { BorrowRequest.count }
      expect(current_path).to eq(address_prompt_path)
    end
  end
end
