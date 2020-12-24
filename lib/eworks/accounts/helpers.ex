defmodule Eworks.Accounts.Helpers do
  @moduledoc false

  @country_codes %{
    "kenya" => "KE",
    "uganda" => "UG",
    "tanzania" => "TZ",
    "Rwanda" => "RW",
    "south sudan" => "SS"
  }

  @doc """
  Validates an email to ensure the email has the the correct format. i.e username@domain.com

  ## Example

      iex> valid_email?("okari@gmail.com")
      true

      iex> valid_email?("okari@me")
      false
  """
  @spec valid_email?(String.t()) :: true | false
  def valid_email?(email) do
    case Regex.run(~r/^[\w.!#$%&’*+\-\/=?\^`{|}~]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*$/i, email) do
      nil ->
        false
      _ ->
        true
    end
  end

  @doc """
  Validates the phone number based on the country entered by the user

  ## Example
      iex> valid_phone?("Kenya", "0723007945")
      true

      iex> valid_phone?("Kenya", "1234542345")
      false
  """
  @spec valid_phone?(String.t(), String.t()) :: true | false
  def valid_phone?(country, phone) when is_binary(country) and is_binary(phone) do
    phone
    # craete the phone number using ExPhoneNUmber
    |> ExPhoneNumber.parse(@country_codes |> Map.fetch!(country |> String.downcase))
    |> elem(1)
    |> ExPhoneNumber.is_valid_number?()
  end

  @doc """
  Takes a list of categories and returns a string seperated by commas

  ## Example
      iex> make_string_from_list(["Events manager", "Software Developer", "Cleaner"])
      "Events manager, Software Developer and Cleaner"
  """
  @spec make_string_from_list(list(String.t())) :: String.t()
  def make_string_from_list([head | tail] = list) when is_list(list) and list != [] do
    if list |> Enum.count() == 2 do
      "#{List.first(list)} and #{List.last(list)}"
    else
      _make_string_from_list(tail, "#{head}")
    end
  end

  @doc false
  @spec _make_string_from_list()
  def _make_string_from_list() do

  end

end
