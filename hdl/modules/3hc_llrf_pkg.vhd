--------------------------------------------------------------------------------
-- Title      : 3rd Hamonic Low-Level Radio Frequency Package
-- Project    : 3rd Hamonic Low-Level Radio Frequency
--------------------------------------------------------------------------------
-- File       : 3hc_llrf_pkg.vhd
-- Author     : Guilherme Ricioli Cruz
-- Company    : CNPEM
-- Platform   : Synthesis
-- Standard   : VHDL'08
--------------------------------------------------------------------------------
-- Description: 3rd Hamonic (3HC) Low-Level Radio Frequency (LLRF) package.
--------------------------------------------------------------------------------
-- Copyright (c) 2026 CNPEM
--------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author              Description
-- 2026-10-30  1.0      guilherme.ricioli   Created
--------------------------------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;

package 3hc_llrf_pkg is
  ------------------------------------------------------------------------------
  -- Constants
  ------------------------------------------------------------------------------
  -- TODO: This should come from the BSP
  constant c_NUM_RF_CHANNELS      : positive := 10;

  ------------------------------------------------------------------------------
  -- Types
  ------------------------------------------------------------------------------
  type t_slv_array is array (natural range <>) of std_logic_vector;
end 3hc_llrf_pkg;
