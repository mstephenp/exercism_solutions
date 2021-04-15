defmodule SpaceAge do
  @type planet ::
            :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @earth_yr_secs 31557600
  @precision 4

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do

    age = &(Float.ceil(seconds / (@earth_yr_secs * &1), @precision))

    case planet do
      :mercury -> age.(0.2408467)
      :venus -> age.(0.61519726)
      :earth -> age.(1)
      :mars -> age.(1.8808158)
      :jupiter -> age.(11.862615)
      :saturn -> age.(29.447498)
      :uranus -> age.(84.016846)
      :neptune -> age.(164.79132)
    end
  end
end
