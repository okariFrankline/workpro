defmodule Eworks.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset
  alias Eworks.Accounts.Validators

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :city, :string
    field :country, :string
    field :county, :string
    field :email, :string
    field :description, :string
    field :full_name, :string
    field :is_active, :boolean, default: false
    field :is_service_provider, :boolean, default: false
    field :is_suspended, :boolean, default: false
    field :is_verified, :string
    field :phone, :string
    field :rating, :integer
    field :street, :string
    field :password, :string
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :phone,
      :email,
      :city,
      :county,
      :street,
      :country,
      :description,
      :rating,
      :full_name,
      :is_service_provider,
      :is_active,
      :is_verified,
      :is_suspended,
      :password_hash
    ])
  end

  @doc false
  def creation_changese(user, attrs) do
    changeset(user, attrs)
    |> cast(attrs, [
      :password
    ])
    |> validate_required([
      :phone,
      :email,
      :city,
      :county,
      :street,
      :country,
      :rating,
      :full_name,
      :is_service_provider,
      :password
    ])
    |> _validate_email()
    |> _validate_phone()
    |> _hash_password()
    # |> add_description()
  end


  @doc false
  def _validate_email(%Changeset{valid?: true, changes: %{email: email}} = changeset) do
    if Validators.valid_email?(email) do
      changeset
    else
      changeset
      |> add_error(:email, "Invalid email entered.")
    end
  end
  def _validate_email(changeset), do: changeset

  @doc false
  def _validate_phone(%Changeset{valid?: true, changes: %{phone: phone, country: country}} = changeset) do
    if Validators.valid_phone?(country, phone) do
      changeset

    else
      changeset
      |> add_error(:phone, "The phone number entered is in an invalid format or not acceptable for the country you live in.")
    end
  end
  def _validate_phone(changeset), do: changeset

  @doc false
  def _hash_password(%Changeset{valid?: true, changes: %{password: pass}} = changeset) do
    changeset
    |> put_change(:password_hash, Argon2.hash_pwd_salt(pass))
  end
  def _hash_password(changeset), do: changeset

  @doc false
  # called if the user registering does not provide a description.
  def _add_description(%Changeset{
    valid?: true,
    changes: %{
      decription: description,
      categories: categories,
      city: city,
      country: country,
      street: street,
      county: county
    }
  } = changeset) when description == "" do
    description = """
      I am a service provider that has specialized in the fields of #{_getSpecialties(categories)} with years of experience and a proven
      record for providing quality services. I am currently based in #{String.capitalize(street)}, #{String.capitalize(city)}
      in  #{String.capitalize(county)}, #{String.capitalize(country)}. However, I am flexible enough to take on jobs that are #{_take_job_outside_location(true)}.
      I look forward to being hired by you and collaborate in your job to ensure the delivery of services that meet your satisfaction.
    """
    changeset
    |> put_change(:description, description)
  end
  # called if user has provided a description.
  def _add_description(%Changeset{valid?: true} = changeset), do: changeset
  def _add_description(changeset), do: changeset

  def _take_job_outside_location(accepts_outside_location) do
    if accepts_outside_location, do: "outside my current location.", else: "outside my location but within my town, estate or street."
  end

  @doc """
  Takes a list of times and returns a string seperated by commas

  ## Example
      iex> _getSpecialties(["Event managing", "Software development"])
      "Event managing, Software development"
  """
  @spec _getSpecialties(list(String.t())) :: String.t()
  def _getSpecialties(categories) when is_list(categories) do
    categories
    |> List.foldr("", fn category, acc ->
      category <> acc <> ", "
    end)
  end

  def make_string([head | tail]) do
    make_string(tail, "#{head}")
  end

  def make_string(list, current_string) when list == [], do: current_string

  def make_string([head | tail] = list, current_string) do
    if Enum.count(list) == 1 do
      current_string <> " and " <> head

    else
      current_string = current_string <> ", " <> head
      make_string(tail, current_string)
    end
  end

  # add description
end
