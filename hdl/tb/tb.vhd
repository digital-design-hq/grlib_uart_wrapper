library ieee;
use ieee.std_logic_1164.all;


entity tb is
end entity;

architecture v1 of tb is

    component echo 
        port (
            rst: in std_ulogic;
            clk: in std_ulogic;

            -- to pins
            txd: out std_logic;
            rxd: in std_logic
        );
    end component;

    signal rst: std_ulogic;
    signal clk: std_ulogic;
    signal txd: std_logic;
    signal rxd: std_logic;

begin

    process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    process
    begin
        rst <= '0';
        wait for 45 ns;
        rst <= '1';
        wait;
    end process;

    process

        procedure onebit (b: std_logic) is
        begin
            for i in 0 to 100 loop
                wait until clk'event and clk = '0';
            end loop;
            rxd <= b;
        end procedure;

        procedure onebyte (b: std_logic_vector (7 downto 0)) is
        begin
            onebit('1');
            onebit('1');
            onebit('1');
            onebit('0');
            onebit(b(0));
            onebit(b(1));
            onebit(b(2));
            onebit(b(3));
            onebit(b(4));
            onebit(b(5));
            onebit(b(6));
            onebit(b(7));
            onebit('1');
            onebit('1');
            onebit('1');
            onebit('1');
        end procedure;

    begin
        rxd <= '1';
        onebyte(x"55");
        onebyte(x"55");
        onebyte(x"55");
        onebyte(x"55");
        assert false severity failure;
        wait;
    end process;

    uut: echo 
        port map (
            rst => rst,
            clk => clk,

            -- to pins
            txd => txd,
            rxd => rxd
        );

end v1;
