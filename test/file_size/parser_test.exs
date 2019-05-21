defmodule FileSize.ParserTest do
  use ExUnit.Case

  alias FileSize.ParseError
  alias FileSize.Parser

  @units [
    # Bit
    {:bit, ["bit", "Bit", "BIT"]},
    {:kbit, ["kbit", "kBit", "Kbit"]},
    {:kibit, ["kibit", "Kibit"]},
    {:mbit, ["mbit", "MBit", "Mbit"]},
    {:mibit, ["mibit", "Mibit"]},
    {:gbit, ["gbit", "GBit", "Gbit"]},
    {:gibit, ["gibit", "Gibit"]},
    {:tbit, ["tbit", "TBit", "Tbit"]},
    {:tibit, ["tibit", "Tibit"]},
    {:pbit, ["pbit", "PBit", "Pbit"]},
    {:pibit, ["pibit", "Pibit"]},
    {:ebit, ["ebit", "EBit", "Ebit"]},
    {:eibit, ["eibit", "Eibit"]},
    {:zbit, ["zbit", "ZBit", "Zbit"]},
    {:zibit, ["zibit", "Zibit"]},
    {:ybit, ["ybit", "YBit", "Ybit"]},
    {:yibit, ["yibit", "Yibit"]},
    # Byte
    {:b, ["b", "B"]},
    {:kb, ["kb", "kB", "KB"]},
    {:kib, ["kib", "KiB", "KIB"]},
    {:mb, ["mb", "MB"]},
    {:mib, ["MiB", "MIB"]},
    {:gb, ["gb", "GB"]},
    {:gib, ["GiB", "GIB"]},
    {:tb, ["tb", "TB"]},
    {:tib, ["TiB", "TIB"]},
    {:pb, ["pb", "PB"]},
    {:pib, ["PiB", "PIB"]},
    {:eb, ["eb", "EB"]},
    {:eib, ["EiB", "EIB"]},
    {:zb, ["zb", "ZB"]},
    {:zib, ["ZiB", "ZIB"]},
    {:yb, ["yb", "YB"]},
    {:yib, ["YiB", "YIB"]}
  ]

  describe "parse/1" do
    test "success with Bit struct" do
      size = FileSize.new(1337, :bit)

      assert Parser.parse(size) == {:ok, size}
    end

    test "success with Byte struct" do
      size = FileSize.new(1337, :b)

      assert Parser.parse(size) == {:ok, size}
    end

    Enum.each(@units, fn {unit, unit_strs} ->
      test "parse string with #{unit} unit" do
        Enum.each(unquote(unit_strs), fn unit_str ->
          assert Parser.parse("1337 #{unit_str}") ==
                   {:ok, FileSize.new(1337, unquote(unit))}

          assert Parser.parse("1337.4 #{unit_str}") ==
                   {:ok, FileSize.new(1337.4, unquote(unit))}
        end)
      end
    end)

    test "invalid format" do
      Enum.each(
        [:invalid, "", " ", "1234", "1234.5", "A B", 12, 12.34],
        fn value ->
          assert Parser.parse(value) ==
                   {:error, %ParseError{reason: :format, value: value}}
        end
      )
    end

    test "invalid value error" do
      Enum.each(["1337,0 B"], fn value ->
        assert Parser.parse(value) ==
                 {:error, %ParseError{reason: :value, value: value}}
      end)
    end

    test "invalid unit error" do
      Enum.each(["1337 U", "1337 ok", "1337.6 U"], fn value ->
        assert Parser.parse(value) ==
                 {:error, %ParseError{reason: :unit, value: value}}
      end)
    end
  end

  describe "parse/2" do
    test "success with Bit struct" do
      size = FileSize.new(1337, :bit)

      assert Parser.parse!(size) == size
    end

    test "success with Byte struct" do
      size = FileSize.new(1337, :b)

      assert Parser.parse!(size) == size
    end

    Enum.each(@units, fn {unit, unit_strs} ->
      test "parse string with #{unit} unit" do
        Enum.each(unquote(unit_strs), fn unit_str ->
          assert Parser.parse!("1337 #{unit_str}") ==
                   FileSize.new(1337, unquote(unit))

          assert Parser.parse!("1337.4 #{unit_str}") ==
                   FileSize.new(1337.4, unquote(unit))
        end)
      end
    end)

    test "invalid format" do
      Enum.each(
        [:invalid, "", " ", "1234", "1234.5", "A B", 12, 12.34],
        fn value ->
          assert_raise ParseError,
                       "Unable to parse value: #{inspect(value)} (format)",
                       fn ->
                         Parser.parse!(value)
                       end
        end
      )
    end

    test "invalid value error" do
      Enum.each(["1337,0 B"], fn value ->
        assert_raise ParseError,
                     "Unable to parse value: #{inspect(value)} (value)",
                     fn ->
                       Parser.parse!(value)
                     end
      end)
    end

    test "invalid unit error" do
      Enum.each(["1337 U", "1337 ok", "1337.6 U"], fn value ->
        assert_raise ParseError,
                     "Unable to parse value: #{inspect(value)} (unit)",
                     fn ->
                       Parser.parse!(value)
                     end
      end)
    end
  end
end