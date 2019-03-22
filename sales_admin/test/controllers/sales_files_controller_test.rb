require 'test_helper'

class SalesFilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sales_file = sales_files(:one)
  end

  test "should get index" do
    get sales_files_url
    assert_response :success
  end

  test "should get new" do
    get new_sales_file_url
    assert_response :success
  end

  test "should create sales_file" do
    assert_difference('SalesFile.count') do
      post sales_files_url, params: { sales_file: { description: @sales_file.description } }
    end

    assert_redirected_to sales_file_url(SalesFile.last)
  end

  test "should show sales_file" do
    get sales_file_url(@sales_file)
    assert_response :success
  end

  test "should destroy sales_file" do
    assert_difference('SalesFile.count', -1) do
      delete sales_file_url(@sales_file)
    end

    assert_redirected_to sales_files_url
  end
end
