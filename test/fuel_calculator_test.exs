defmodule FuelCalculatorTest do
  use ExUnit.Case

  describe "calculate_total_fuel_needed/2" do
    test "calculate_total_fuel_needed returns correct fuel for Apollo 11 mission" do
      flight_path = [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}]
      mass = 28801
      assert FuelCalculator.calculate_total_fuel_needed(mass, flight_path) == 51898
    end

    test "calculate_total_fuel_needed returns correct fuel for mission on Mars" do
      flight_path = [{:launch, 9.807}, {:land, 3.711}, {:launch, 3.711}, {:land, 9.807}]
      mass = 14606
      assert FuelCalculator.calculate_total_fuel_needed(mass, flight_path) == 33388
    end

    test "calculate_total_fuel_needed returns correct fuel for passenger ship" do
      flight_path = [
        {:launch, 9.807},
        {:land, 1.62},
        {:launch, 1.62},
        {:land, 3.711},
        {:launch, 3.711},
        {:land, 9.807}
      ]

      mass = 75432
      assert FuelCalculator.calculate_total_fuel_needed(mass, flight_path) == 212_161
    end

    test "calculate_total_fuel_needed returns {:error, :wrong_path} when wrong path given" do
      mass = 75432
      flight_path = ""
      assert FuelCalculator.calculate_total_fuel_needed(mass, flight_path) == {:error, :wrong_path}
    end

    test "calculate_total_fuel_needed returns {:error, :wrong_path} when one element contains typo" do
      mass = 12
      flight_path = [{:launch, 9.807}, {:Zand, 1.62}, {:launch, 1.62}, {:land, 9.807}]
      assert FuelCalculator.calculate_total_fuel_needed(mass, flight_path) == {:error, :wrong_path}
    end

    test "calculate_total_fuel_needed returns {:error, :wrong_path} when path is not a list" do
      mass = 12
      flight_path = "test"
      assert FuelCalculator.calculate_total_fuel_needed(mass, flight_path) == {:error, :wrong_path}
    end

    test "calculate_total_fuel_needed returns {:error, :wrong_mass} when wrong path given" do
      mass = "test"
      flight_path = [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}]
      assert FuelCalculator.calculate_total_fuel_needed(mass, flight_path) == {:error, :wrong_mass}
    end
  end
end
