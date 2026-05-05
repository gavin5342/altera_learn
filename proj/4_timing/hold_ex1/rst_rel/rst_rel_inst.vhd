	component rst_rel is
		port (
			ninit_done : out std_logic   -- ninit_done
		);
	end component rst_rel;

	u0 : component rst_rel
		port map (
			ninit_done => CONNECTED_TO_ninit_done  -- ninit_done.ninit_done
		);

