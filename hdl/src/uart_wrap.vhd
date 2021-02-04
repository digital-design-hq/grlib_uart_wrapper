-- this block detects baudrate. send 0x55 or 0xAA after reset to let it catch baudrate
-- all symbols are discarded until the baudrate is detected (lock goes high when this happens)
library ieee;
use ieee.std_logic_1164.all;
library grlib;
use grlib.amba.all;
library gaisler;
use gaisler.libdcom.all;
use gaisler.uart.all;

entity uart_wrap is
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
end entity; 

architecture v1 of uart_wrap is

    component dcom_uart 
        port (
            rst: in std_ulogic;
            clk: in std_ulogic;
            ui: in uart_in_type;
            uo: out uart_out_type;
            apbi: in apb_slv_in_type;
            apbo: out apb_slv_out_type;
            uarti: in dcom_uart_in_type;
            uarto: out dcom_uart_out_type
        );
    end component; 

    signal ui: uart_in_type;
    signal uo: uart_out_type;
    signal uarti: dcom_uart_in_type;
    signal uarto: dcom_uart_out_type;

begin

    uarti.read <= read;
    uarti.write <= write;
    uarti.data <= txdata;

    dready <= uarto.dready;
    rxdata <= uarto.data;
    txempty <= uarto.thempty;
    
    lock <= uarto.lock;

    ui.rxd <= rxd;
    txd <= uo.txd;

    core: dcom_uart 
        port map (
            rst => rst,
            clk => clk,
            ui => ui,
            uo => uo,
            apbi => apb_slv_in_none,
            uarti => uarti,
            uarto => uarto
        );

end v1;

