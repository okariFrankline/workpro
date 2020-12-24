defmodule Eworks.Accounts.ValidatorsTest do
  use ExUnit.Case

  alias Eworks.Accounts.Validators

  test "ensures and email given is true" do
    assert Validators.valid_email?("okarifrank@gmail.com") == true
  end

  test "ensures an incorrect email returns false" do
    assert Validators.valid_email?("okari@") == false
  end


  describe "Tests whether the phone number entered by a user is valid for the country the live in." do
    test "valid county and valid phone number" do
      assert Validators.valid_phone?("Kenya", "0723007945") == true
    end

    test "invalid number for valid country" do
      assert Validators.valid_phone?("Kenya", "1234567890") == false
    end

  end

end
