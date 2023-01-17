# Nasa

FuelCalculator is an Elixir module that calculates the amount of fuel needed for a specific flight route.

## Installation

The Elixir version required is `1.13` or above.

To use this module: 
1. Open the project directory in your terminal
2. Start the Elixir console by typing `iex`
3. Compile the FuelCalculator module by typing `c "lib/fuel_calculator.ex"` 
4. Run script by compiling it with `c "lib/fuel_calculator_app.exs"`


## Tests
To run tests in project direcotry type `mix test`

## Usage
The FuelCalculatorApp script will prompt the user to enter the `mass` of the ship which is number bigger than 0, and the `path` of the ship which is list of tuples, where the first element is an antom `:land` or `:launch` and the second element is number value of the gravity. So example parameters are:

* 28801
* [{:launch, 9.807}, {:land, 3.711}, {:launch, 3.711}, {:land, 9.807}]

The script will then call the `FuelCalculator.calculate_total_fuel_needed(mass, path)` function, which takes the mass of the ship and the flight route as input and returns the total amount of fuel needed. If the provided mass or path are not valid, the script will return an error message.

