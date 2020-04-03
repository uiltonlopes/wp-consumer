require "application_system_test_case"

class NamespacesTest < ApplicationSystemTestCase
  setup do
    @namespace = namespaces(:one)
  end

  test "visiting the index" do
    visit namespaces_url
    assert_selector "h1", text: "Namespaces"
  end

  test "creating a Namespace" do
    visit namespaces_url
    click_on "New Namespace"

    fill_in "Namespace", with: @namespace.namespace
    click_on "Create Namespace"

    assert_text "Namespace was successfully created"
    click_on "Back"
  end

  test "updating a Namespace" do
    visit namespaces_url
    click_on "Edit", match: :first

    fill_in "Namespace", with: @namespace.namespace
    click_on "Update Namespace"

    assert_text "Namespace was successfully updated"
    click_on "Back"
  end

  test "destroying a Namespace" do
    visit namespaces_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Namespace was successfully destroyed"
  end
end
