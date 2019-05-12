defmodule EvilCorp.Identity.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :name])
    |> validate_required([:email, :name])
  end

  def signup_changeset(user, attrs) do
    user
    |> changeset(attrs)
    |> cast(attrs, [:password])
    |> validate_required([:password])
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case fetch_change(changeset, :password) do
      {:ok, _pw} ->
        changeset
        |> put_change(:password_hash, "Not a Hash")
        |> delete_change(:password)

      _ ->
        changeset
    end
  end
end
