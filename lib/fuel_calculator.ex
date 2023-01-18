defmodule FuelCalculator do
  @moduledoc """
  FuelCalculator is a module that calculates the amount of fuel needed for a specific flight route
  """

  @doc """
  Calculates the total amount of fuel needed for a specific flight route
  @param mass The mass of the ship
  @param path The flight route represented as a list of tuples, where the first element is a keyword
  representing a launch or land operation and the second element is the gravity of the planet
  @return The total amount of fuel needed
  """
  @spec calculate_total_fuel_needed(pos_integer(), list()) ::
          pos_integer() | {:error, :wrong_mass} | {:error, :wrong_path}
  def calculate_total_fuel_needed(mass, path) do
    with {:ok, :mass_correct} <- validate_mass(mass),
         {:ok, :path_correct} <- validate_path(path) do
      mass_with_fuel =
        path
        |> Enum.reverse()
        |> Enum.reduce(mass, fn {action, gravity}, acc ->
          fuel_needed_for_initial_mass = calculate_fuel(action, acc, gravity)

          additional_fuel_needed =
            calculate_extra_fuel_needed(action, fuel_needed_for_initial_mass, gravity)

          total_fuel = fuel_needed_for_initial_mass + additional_fuel_needed

          acc + total_fuel
        end)

      mass_with_fuel - mass
    end
  end

  defp calculate_fuel(:launch, mass, gravity) do
    :math.floor(mass * gravity * 0.042 - 33)
  end

  defp calculate_fuel(:land, mass, gravity) do
    :math.floor(mass * gravity * 0.033 - 42)
  end

  defp calculate_extra_fuel_needed(action, mass, gravity, sum \\ 0) do
    additional_fuel = calculate_fuel(action, mass, gravity)

    if additional_fuel > 0 do
      calculate_extra_fuel_needed(action, additional_fuel, gravity, additional_fuel + sum)
    else
      sum
    end
  end

  defp validate_mass(mass) when is_number(mass) and mass > 0, do: {:ok, :mass_correct}
  defp validate_mass(_mass), do: {:error, :wrong_mass}

  def validate_path(path) do
    case path do
      [] ->
        {:ok, :path_correct}

      [{first, second} | tail]
      when is_atom(first) and first in [:land, :launch] and is_number(second) ->
        validate_path(tail)

      _ ->
        {:error, :wrong_path}
    end
  end
end
