defmodule EworksWeb.UserView do
  use EworksWeb, :view
  alias EworksWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      phone: user.phone,
      email: user.email,
      city: user.city,
      county: user.county,
      street: user.street,
      country: user.country,
      rating: user.rating,
      full_name: user.full_name,
      is_client: user.is_client,
      is_active: user.is_active,
      is_verified: user.is_verified,
      is_suspended: user.is_suspended}
  end
end
