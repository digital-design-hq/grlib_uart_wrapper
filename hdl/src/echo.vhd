library ieee;
use ieee.std_logic_1164.all;


entity echo is
    port (
        rst: in std_ulogic;
        clk: in std_ulogic;

        -- to pins
        txd: out std_logic;
        rxd: in std_logic
    );
end entity;

architecture v1 of echo is

    component uart_wrap
        port (
            rst: in std_ulogic;
            clk: in std_ulogic;

            -- to pins
            txd: out std_logic;
            rxd: in std_logic;

            -- baudrate detector state
            lock: out std_logic; -- goes high when baudrate is detected

            -- to logic: rx
            dready: out std_logic; -- you can read from this module when dready is high
            rxdata: out std_logic_vector (7 downto 0); -- this signal is valid when dready is high
            read: in std_logic; -- shift out data

            -- to logic: tx
            txempty: out std_logic; -- you can write to this module if txempty is high
            txdata: in std_logic_vector (7 downto 0);
            write: in std_logic
        );
    end component; 

    signal lock: std_logic; -- goes high when baudrate is detected
    signal dready: std_logic; -- you can read from this module when dready is high
    signal rxdata: std_logic_vector (7 downto 0); -- this signal is valid when dready is high
    signal read: std_logic; -- shift out data
    signal txempty: std_logic; -- you can write to this module if txempty is high
    signal txdata: std_logic_vector (7 downto 0);
    signal write: std_logic;

    signal sRd: std_logic;

begin

    sRd <= '1' when txempty = '1' and dready = '1' else '0';
    read <= sRd;
    write <= sRd;
    txdata <= rxdata;

    uut: uart_wrap
        port map (
            rst => rst,
            clk => clk,

            -- to pins
            txd => txd,
            rxd => rxd,

            -- baudrate detector state
            lock => lock,

            -- to logic: rx
            dready => dready,
            rxdata => rxdata,
            read => read,

            -- to logic: tx
            txempty => txempty,
            txdata => txdata,
            write => write
        );

end v1;

