// (C) 2001-2026 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


`timescale 1ps/1ps

module compare_eq #(
    parameter WIDTH=10
) (
    input [WIDTH-1:0]  in_a,
    input [WIDTH-1:0]  in_b,
    output             equal
);

assign equal = (in_a==in_b);

endmodule 
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "mfufSZOYfNPxmSfS+FkCl32e9bHGnpakqHX1nHXvrhE4J6x8qGVCEAJRqHIBXSp/FcyWPq9/UmljeMey51E9VTMH3OCNEvZdEUSPU4/Vf6DgtU26zIfR3Ws2AtmUBXEHD5yEeHuHpEMedz5PLIdzFsBxJ/9OiyM+8A3UVG3icM2FQlZPfaXli71zX1obNH4Hi4tyLUZvYQoJv7xSQMqW1lxant16XP5C2V2aZfTOCZm7JmApZc4p7EXtSXxjB72R3HEVlJX9JUjoAlQrH7MXXjD0z5+xV3cjwU2g3DOWVu5P4rIHbU9mq65nwA9A5DFW+qdyjKvuaSWS2IizWC2pBl+LgaQoo2UzAXNtrk7MrdjyxL09fW3upp2xzBuqSghizncf+xEINey3XyKN3yaORZnONczaV8OwXiVSqMGV/BTLgeHz0GVQjIj+pjrP0QOO5TjOX0TA40R+k0SCs5tGQqJIRl5Nsr72rVcSxC2TD9EjT6lA2ESUEpS4JiSW2r2EABiNeKg73SEU0TVyv971W3ZPEGEzxKx9AoUS6NWUvdOH0KXlwoXK/Oq78cobSSRyODSL5NMYErVOwTHmQvpIuZlAjJvqksE9kYyjgarAmoWehNpER7Eck1oUAPNTS3pD3bfzURMbHRsDNVOKFKxuDWwG3CrKW79yqJMDitg0TFTBV4tY7anrIQ1LDXTH+Ng5vhx3xKNPIr1t3egMkhfkLS2mHev+51l2tB2o93RvYLodn8LuFcJ6PnRdI2nfQHkleYhxm3ASjmlzYf4/9iJTULHYzjzQi51pVaxtS3GzxSg3rQ4Oebl18PUYOrwVGMR77Rw1TUEo+phrQIUc/PXvY8g4F8PEtK9VPVdmZcjn3hmsukXDt8EtmQEIOgkEH8U/Ip/6DuZ+KI6P0wOks6ixGc7RLPjzTzdHKXJ3E4dBUEYpeq3htR5tDJZ7TPgYtxsaKnv8Naq6ftCdkJcvxu2l8FhoK+tJFnShkRAg0rBEikV7fWFwymxsvC0TVqYrfNWQ"
`endif