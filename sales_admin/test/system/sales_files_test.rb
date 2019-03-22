require "application_system_test_case"

class SalesFilesTest < ApplicationSystemTestCase
  setup do
    @sales_file = sales_files(:one)
  end

  test "visiting the index" do
    visit sales_files_url
    assert_selector "h1", text: "Sales Files"
  end

  test "creating a Sales file" do
    visit sales_files_url
    click_on "New Sales File"

    fill_in "Description", with: @sales_file.description
    click_on "Create Sales file"

    assert_text "Sales file was successfully created"
    click_on "Back"
  end

  test "updating a Sales file" do
    visit sales_files_url
    click_on "Edit", match: :first

    fill_in "Description", with: @sales_file.description
    click_on "Update Sales file"

    assert_text "Sales file was successfully updated"
    click_on "Back"
  end

  test "destroying a Sales file" do
    visit sales_files_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Sales file was successfully destroyed"
  end
end
