--------------------------------------------------------------------------------
-- Title      : 3rd Hamonic Low-Level Radio Frequency Top-Level Digital Signal
--              Processing Chain
-- Project    : 3rd Hamonic Low-Level Radio Frequency
--------------------------------------------------------------------------------
-- File       : 3hc_llrf_dsp.vhd
-- Author     : Guilherme Ricioli Cruz
-- Company    : CNPEM
-- Platform   : Synthesis
-- Standard   : VHDL'08
--------------------------------------------------------------------------------
-- Description: 3rd Hamonic (3HC) Low-Level Radio Frequency (LLRF) top-level
--              digital signal processing chain.
--
--              Its assumed that the intermediate frequency is locked to and
--              exactly 1/4 of the sampling frequency.
--------------------------------------------------------------------------------
-- Copyright (c) 2026 CNPEM
--------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author              Description
-- 2026-10-29  1.0      guilherme.ricioli   Created
--------------------------------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;

library work;
  use work.3hc_llrf_dsp_pkg.all;

entity 3hc_llrf_dsp is
  generic (
    -- ADC data width
    g_ADC_DATA_WIDTH                  : positive
  );
  port (
    -- System clock
    clk_sys_i                         : in std_logic;

    -- Sampling clock
    clk_sampling_i                    : in std_logic;

    -- Reset
    rst_i                             : in std_logic;

    -- ADC data input in 2's complement
    -- Domain: clk_sampling_i
    -- IQ demodulator assumes ADC data is feed is every sampling clock
    adc_data_arr_i                    : in t_slv_array(
                                            c_NUM_RF_CHANNELS-1 downto 0
                                           )(
                                            g_ADC_DATA_WIDTH-1 downto 0
                                           );

    -- ADC data demodulated IQ components
    -- Domain: clk_sampling_i
    dbg_iq_demodulator_i_arr_o        : out t_slv_array(
                                             c_NUM_RF_CHANNELS-1 downto 0
                                            )(
                                             g_ADC_DATA_WIDTH downto 0
                                            );
    dbg_iq_demodulator_q_arr_o        : out t_slv_array(
                                            c_NUM_RF_CHANNELS-1 downto 0
                                            )(
                                             g_ADC_DATA_WIDTH downto 0
                                            );
    dbg_iq_demodulator_iq_valid_arr_o : out std_logic_vector(
                                              c_NUM_RF_CHANNELS-1 downto 0
                                            )
  );
end entity;

architecture structural of 3hc_llrf_dsp is
  ------------------------------------------------------------------------------
  -- Signals
  ------------------------------------------------------------------------------
  signal iq_demodulator_i_arr         : t_slv_array(
                                          c_NUM_RF_CHANNELS-1 downto 0
                                        )(
                                          g_ADC_DATA_WIDTH downto 0
                                        ) := (others => (others => '0'));
  signal iq_demodulator_q_arr         : t_slv_array(
                                          c_NUM_RF_CHANNELS-1 downto 0
                                        )(
                                          g_ADC_DATA_WIDTH downto 0
                                        ) := (others => (others => '0'));
  signal iq_demodulator_iq_valid_arr  : std_logic_vector(
                                          c_NUM_RF_CHANNELS-1 downto 0
                                        ) := (others => '0');
begin
  gen_rf_measurement : for i in 0 to c_NUM_RF_CHANNELS-1 generate
  begin
    ----------------------------------------------------------------------------
    -- IQ Demodulator
    ----------------------------------------------------------------------------
    cmp_iq_demodulator : entity work.gc_iq_demodulator
      generic map (
        g_N         => g_ADC_DATA_WIDTH
      )
      port map (
        clk_i       => clk_sampling_i,
        rst_i       => rst_i,
        -- No plans for synchronizing this
        sync_p1_i   => '0',
        adc_data_i  => adc_data_arr_i(i),
        i_o         => iq_demodulator_i_arr(i),
        q_o         => iq_demodulator_q_arr(i)
      );
    -- IQ demodulator's output is always valid
    iq_demodulator_iq_valid_arr(i) <= '1';

    ----------------------------------------------------------------------------
    -- Debug signals
    ----------------------------------------------------------------------------
    dbg_iq_demodulator_i_arr_o(i) <= iq_demodulator_i_arr(i);
    dbg_iq_demodulator_q_arr_o(i) <= iq_demodulator_q_arr(i);
    dbg_iq_demodulator_iq_valid_arr_o(i) <= iq_demodulator_iq_valid_arr(i);
  end generate gen_rf_measurement;
end architecture structural;
