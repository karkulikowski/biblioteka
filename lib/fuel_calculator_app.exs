defmodule FuelCalculatorApp do
  def run do
    IO.puts("Welcome to the NASA Fuel Calculator")
    IO.puts("Please enter the mass of the ship:")
    mass = IO.gets("Mass: ") |> String.trim() |> String.to_integer()

    IO.puts("Please enter the flight route as a list of tuples in the format:")
    IO.puts("[{:launch, gravity}, {:land, gravity}, ...]")
    {path, _} = IO.gets("Path: ") |> String.trim() |> Code.eval_string()

    fuel = FuelCalculator.calculate_total_fuel_needed(mass, path)

    case fuel do
      {:error, :wrong_path} -> IO.puts("You provided wrong path")
      {:error, :wrong_mass} -> IO.puts("You provided wrong mass")
      fuel_needed -> IO.puts("The total fuel needed for this flight route is: #{fuel_needed}")
    end
  end
end

FuelCalculatorApp.run()
