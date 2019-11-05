defmodule View do
  use Spigot, :view

  def render("iodata", %{name: name}) do
    ~i(Hello, #{name})
  end

  def render("string", %{name: name}) do
    ~s(Hello, #{name})
  end

  def render("iodata-long", %{character: character}) do
    ~E"""
    <%= character.name %>
    -----

    HP: <%= character.hp %>/<%= character.maxhp %>
    SP: <%= character.sp %>/<%= character.maxsp %>
    EP: <%= character.ep %>/<%= character.maxep %>

    Items:
    -------

    <%= Enum.map(character.items, &render("item-io", &1)) %>
    """
  end

  def render("item-io", %{name: name}) do
    ~i(- #{name})
  end

  def render("string-long", %{character: character}) do
    """
    #{character.name}
    -----

    HP: #{character.hp}/#{character.maxhp}
    SP: #{character.sp}/#{character.maxsp}
    EP: #{character.ep}/#{character.maxep}

    Items:
    -------

    #{Enum.map(character.items, &render("item-string", &1))}
    """
  end

  def render("item-string", %{name: name}) do
    ~s(- #{name})
  end
end

character = %{
  name: "Eric",
  hp: 50,
  maxhp: 50,
  sp: 35,
  maxsp: 35,
  ep: 22,
  maxep: 25,
  items: [
    %{name: "Potion"},
    %{name: "Sword"}
  ]
}

Benchee.run(%{
  "iodata" => fn -> View.render("iodata", %{name: "Eric"}) end,
  "string" => fn -> View.render("string", %{name: "Eric"}) end
})

Benchee.run(%{
  "iodata" => fn -> View.render("iodata-long", %{character: character}) end,
  "string" => fn -> View.render("string-long", %{character: character}) end
})
