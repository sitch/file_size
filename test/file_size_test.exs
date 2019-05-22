defmodule FileSizeTest do
  use ExUnit.Case

  alias FileSize.Bit
  alias FileSize.Byte
  alias FileSize.Calculable
  alias FileSize.Comparable
  alias FileSize.Convertible
  alias FileSize.Formatter
  alias FileSize.InvalidUnitError
  alias FileSize.Parser

  describe "new/1" do
    test "use byte as default unit" do
      assert FileSize.new(1) == %Byte{
               value: 1,
               unit: :b,
               bytes: 1,
               unit_prefix: nil,
               unit_system: nil
             }
    end
  end

  describe "new/2" do
    test "bit" do
      assert FileSize.new(1, :bit) == %Bit{
               value: 1,
               unit: :bit,
               bits: 1,
               unit_prefix: nil,
               unit_system: nil
             }
    end

    test "kbit" do
      assert FileSize.new(1, :kbit) == %Bit{
               value: 1,
               unit: :kbit,
               bits: 1000,
               unit_prefix: :kilo,
               unit_system: :si
             }
    end

    test "Kibit" do
      assert FileSize.new(1, :kibit) == %Bit{
               value: 1,
               unit: :kibit,
               bits: 1024,
               unit_prefix: :kibi,
               unit_system: :iec
             }
    end

    test "Mbit" do
      assert FileSize.new(1, :mbit) == %Bit{
               value: 1,
               unit: :mbit,
               bits: Math.pow(1000, 2),
               unit_prefix: :mega,
               unit_system: :si
             }
    end

    test "Mibit" do
      assert FileSize.new(1, :mibit) == %Bit{
               value: 1,
               unit: :mibit,
               bits: Math.pow(1024, 2),
               unit_prefix: :mebi,
               unit_system: :iec
             }
    end

    test "Gbit" do
      assert FileSize.new(1, :gbit) == %Bit{
               value: 1,
               unit: :gbit,
               bits: Math.pow(1000, 3),
               unit_prefix: :giga,
               unit_system: :si
             }
    end

    test "Gibit" do
      assert FileSize.new(1, :gibit) == %Bit{
               value: 1,
               unit: :gibit,
               bits: Math.pow(1024, 3),
               unit_prefix: :gibi,
               unit_system: :iec
             }
    end

    test "Tbit" do
      assert FileSize.new(1, :tbit) == %Bit{
               value: 1,
               unit: :tbit,
               bits: Math.pow(1000, 4),
               unit_prefix: :tera,
               unit_system: :si
             }
    end

    test "Tibit" do
      assert FileSize.new(1, :tibit) == %Bit{
               value: 1,
               unit: :tibit,
               bits: Math.pow(1024, 4),
               unit_prefix: :tebi,
               unit_system: :iec
             }
    end

    test "Pbit" do
      assert FileSize.new(1, :pbit) == %Bit{
               value: 1,
               unit: :pbit,
               bits: Math.pow(1000, 5),
               unit_prefix: :peta,
               unit_system: :si
             }
    end

    test "Pibit" do
      assert FileSize.new(1, :pibit) == %Bit{
               value: 1,
               unit: :pibit,
               bits: Math.pow(1024, 5),
               unit_prefix: :pebi,
               unit_system: :iec
             }
    end

    test "Ebit" do
      assert FileSize.new(1, :ebit) == %Bit{
               value: 1,
               unit: :ebit,
               bits: Math.pow(1000, 6),
               unit_prefix: :exa,
               unit_system: :si
             }
    end

    test "Eibit" do
      assert FileSize.new(1, :eibit) == %Bit{
               value: 1,
               unit: :eibit,
               bits: Math.pow(1024, 6),
               unit_prefix: :exbi,
               unit_system: :iec
             }
    end

    test "Zbit" do
      assert FileSize.new(1, :zbit) == %Bit{
               value: 1,
               unit: :zbit,
               bits: Math.pow(1000, 7),
               unit_prefix: :zeta,
               unit_system: :si
             }
    end

    test "Zibit" do
      assert FileSize.new(1, :zibit) == %Bit{
               value: 1,
               unit: :zibit,
               bits: Math.pow(1024, 7),
               unit_prefix: :zebi,
               unit_system: :iec
             }
    end

    test "Ybit" do
      assert FileSize.new(1, :ybit) == %Bit{
               value: 1,
               unit: :ybit,
               bits: Math.pow(1000, 8),
               unit_prefix: :yotta,
               unit_system: :si
             }
    end

    test "Yibit" do
      assert FileSize.new(1, :yibit) == %Bit{
               value: 1,
               unit: :yibit,
               bits: Math.pow(1024, 8),
               unit_prefix: :yobi,
               unit_system: :iec
             }
    end

    test "byte" do
      assert FileSize.new(1, :b) == %Byte{
               value: 1,
               unit: :b,
               bytes: 1,
               unit_prefix: nil,
               unit_system: nil
             }
    end

    test "kB" do
      assert FileSize.new(1, :kb) == %Byte{
               value: 1,
               unit: :kb,
               bytes: 1000,
               unit_prefix: :kilo,
               unit_system: :si
             }
    end

    test "KiB" do
      assert FileSize.new(1, :kib) == %Byte{
               value: 1,
               unit: :kib,
               bytes: 1024,
               unit_prefix: :kibi,
               unit_system: :iec
             }
    end

    test "MB" do
      assert FileSize.new(1, :mb) == %Byte{
               value: 1,
               unit: :mb,
               bytes: Math.pow(1000, 2),
               unit_prefix: :mega,
               unit_system: :si
             }
    end

    test "MiB" do
      assert FileSize.new(1, :mib) == %Byte{
               value: 1,
               unit: :mib,
               bytes: Math.pow(1024, 2),
               unit_prefix: :mebi,
               unit_system: :iec
             }
    end

    test "GB" do
      assert FileSize.new(1, :gb) == %Byte{
               value: 1,
               unit: :gb,
               bytes: Math.pow(1000, 3),
               unit_prefix: :giga,
               unit_system: :si
             }
    end

    test "GiB" do
      assert FileSize.new(1, :gib) == %Byte{
               value: 1,
               unit: :gib,
               bytes: Math.pow(1024, 3),
               unit_prefix: :gibi,
               unit_system: :iec
             }
    end

    test "TB" do
      assert FileSize.new(1, :tb) == %Byte{
               value: 1,
               unit: :tb,
               bytes: Math.pow(1000, 4),
               unit_prefix: :tera,
               unit_system: :si
             }
    end

    test "TiB" do
      assert FileSize.new(1, :tib) == %Byte{
               value: 1,
               unit: :tib,
               bytes: Math.pow(1024, 4),
               unit_prefix: :tebi,
               unit_system: :iec
             }
    end

    test "PB" do
      assert FileSize.new(1, :pb) == %Byte{
               value: 1,
               unit: :pb,
               bytes: Math.pow(1000, 5),
               unit_prefix: :peta,
               unit_system: :si
             }
    end

    test "PiB" do
      assert FileSize.new(1, :pib) == %Byte{
               value: 1,
               unit: :pib,
               bytes: Math.pow(1024, 5),
               unit_prefix: :pebi,
               unit_system: :iec
             }
    end

    test "EB" do
      assert FileSize.new(1, :eb) == %Byte{
               value: 1,
               unit: :eb,
               bytes: Math.pow(1000, 6),
               unit_prefix: :exa,
               unit_system: :si
             }
    end

    test "EiB" do
      assert FileSize.new(1, :eib) == %Byte{
               value: 1,
               unit: :eib,
               bytes: Math.pow(1024, 6),
               unit_prefix: :exbi,
               unit_system: :iec
             }
    end

    test "ZB" do
      assert FileSize.new(1, :zb) == %Byte{
               value: 1,
               unit: :zb,
               bytes: Math.pow(1000, 7),
               unit_prefix: :zeta,
               unit_system: :si
             }
    end

    test "ZiB" do
      assert FileSize.new(1, :zib) == %Byte{
               value: 1,
               unit: :zib,
               bytes: Math.pow(1024, 7),
               unit_prefix: :zebi,
               unit_system: :iec
             }
    end

    test "YB" do
      assert FileSize.new(1, :yb) == %Byte{
               value: 1,
               unit: :yb,
               bytes: Math.pow(1000, 8),
               unit_prefix: :yotta,
               unit_system: :si
             }
    end

    test "YiB" do
      assert FileSize.new(1, :yib) == %Byte{
               value: 1,
               unit: :yib,
               bytes: Math.pow(1024, 8),
               unit_prefix: :yobi,
               unit_system: :iec
             }
    end

    test "unknown unit" do
      assert_raise InvalidUnitError, "Invalid unit: :unknown", fn ->
        FileSize.new(1, :unknown)
      end
    end
  end

  describe "from_bytes/2" do
    test "as bytes" do
      assert FileSize.from_bytes(1337, :b) == FileSize.new(1337, :b)
    end

    test "as kB" do
      assert FileSize.from_bytes(1337, :kb) == FileSize.new(1.337, :kb)
    end

    test "invalid unit" do
      assert_raise InvalidUnitError, "Invalid unit: :unknown", fn ->
        FileSize.from_bytes(1337, :unknown)
      end
    end
  end

  describe "from_bits/2" do
    test "as bits" do
      assert FileSize.from_bits(1337, :bit) == FileSize.new(1337, :bit)
    end

    test "as kbits" do
      assert FileSize.from_bits(1337, :kbit) == FileSize.new(1.337, :kbit)
    end

    test "invalid unit" do
      assert_raise InvalidUnitError, "Invalid unit: :unknown", fn ->
        FileSize.from_bits(1337, :unknown)
      end
    end
  end

  describe "from_file/1" do
    test "success" do
      path = "test/fixtures/sample.txt"
      %{size: bytes} = File.stat!(path)

      assert FileSize.from_file(path) == {:ok, FileSize.new(bytes)}
    end

    test "file not found" do
      assert FileSize.from_file("test/fixtures/unknown.txt") ==
               {:error, :enoent}
    end
  end

  describe "from_file/2" do
    test "success" do
      path = "test/fixtures/sample.txt"
      %{size: bytes} = File.stat!(path)

      assert FileSize.from_file(path, :kb) ==
               {:ok, FileSize.from_bytes(bytes, :kb)}
    end

    test "file not found" do
      assert FileSize.from_file("test/fixtures/unknown.txt", :kb) ==
               {:error, :enoent}
    end

    test "invalid unit" do
      assert_raise InvalidUnitError, "Invalid unit: :unknown", fn ->
        FileSize.from_file("test/fixtures/sample.txt", :unknown)
      end
    end
  end

  describe "from_file!/1" do
    test "success" do
      path = "test/fixtures/sample.txt"
      %{size: bytes} = File.stat!(path)

      assert FileSize.from_file!(path) == FileSize.new(bytes)
    end

    test "file not found" do
      assert_raise File.Error, ~r/no such file or directory/, fn ->
        FileSize.from_file!("test/fixtures/unknown.txt")
      end
    end
  end

  describe "from_file!/2" do
    test "success" do
      path = "test/fixtures/sample.txt"
      %{size: bytes} = File.stat!(path)

      assert FileSize.from_file!(path, :kb) == FileSize.from_bytes(bytes, :kb)
    end

    test "file not found" do
      assert_raise File.Error, ~r/no such file or directory/, fn ->
        FileSize.from_file!("test/fixtures/unknown.txt", :kb)
      end
    end

    test "invalid unit" do
      assert_raise InvalidUnitError, "Invalid unit: :unknown", fn ->
        FileSize.from_file!("test/fixtures/sample.txt", :unknown)
      end
    end
  end

  describe "parse/1" do
    test "delegate to Parser" do
      value = "1 GB"

      assert FileSize.parse(value) == Parser.parse(value)
    end
  end

  describe "parse!/1" do
    test "delegate to Parser" do
      value = "1 GB"

      assert FileSize.parse!(value) == Parser.parse!(value)
    end
  end

  describe "format/1" do
    test "delegate to Formatter" do
      size = FileSize.new(1024, :mb)

      assert FileSize.format(size) == Formatter.format(size)
    end
  end

  describe "format/2" do
    test "delegate to Formatter" do
      size = FileSize.new(1024, :mb)
      opts = [delimiter: ",", separator: "."]

      assert FileSize.format(size, opts) == Formatter.format(size, opts)
    end
  end

  describe "convert/2" do
    test "delegate to Convertible" do
      size = FileSize.new(1, :b)

      assert FileSize.convert(size, :bit) == Convertible.convert(size, :bit)
    end
  end

  describe "compare/2" do
    test "delegate to Calculable" do
      a = FileSize.new(1, :b)
      b = FileSize.new(2, :b)

      assert FileSize.compare(a, b) == Comparable.compare(a, b)
    end
  end

  describe "equals?/2" do
    test "true when first equal to second" do
      assert FileSize.equals?(FileSize.new(1, :b), FileSize.new(1, :b)) == true

      assert FileSize.equals?(FileSize.new(1, :bit), FileSize.new(1, :bit)) ==
               true

      assert FileSize.equals?(FileSize.new(8, :bit), FileSize.new(1, :b)) ==
               true

      assert FileSize.equals?(FileSize.new(1000, :b), FileSize.new(1, :kb)) ==
               true
    end

    test "false when first not equal to second" do
      assert FileSize.equals?(FileSize.new(1, :b), FileSize.new(2, :b)) == false

      assert FileSize.equals?(FileSize.new(1, :bit), FileSize.new(2, :b)) ==
               false

      assert FileSize.equals?(FileSize.new(1, :bit), FileSize.new(2, :bit)) ==
               false

      assert FileSize.equals?(FileSize.new(1, :b), FileSize.new(1, :kb)) ==
               false

      assert FileSize.equals?(FileSize.new(1, :b), FileSize.new(1, :kib)) ==
               false

      assert FileSize.equals?(FileSize.new(2, :b), FileSize.new(1, :b)) == false

      assert FileSize.equals?(FileSize.new(2, :b), FileSize.new(1, :bit)) ==
               false

      assert FileSize.equals?(FileSize.new(2, :bit), FileSize.new(1, :bit)) ==
               false

      assert FileSize.equals?(FileSize.new(1, :kb), FileSize.new(1, :b)) ==
               false

      assert FileSize.equals?(FileSize.new(1, :kib), FileSize.new(1, :b)) ==
               false
    end
  end

  describe "add/2" do
    test "delegate to Calculable" do
      a = FileSize.new(1, :b)
      b = FileSize.new(2, :b)

      assert FileSize.add(a, b) == Calculable.add(a, b)
    end
  end

  describe "add/3" do
    test "delegate to Calculable and convert" do
      a = FileSize.new(1, :b)
      b = FileSize.new(2, :b)

      assert FileSize.add(a, b, :kb) ==
               FileSize.convert(Calculable.add(a, b), :kb)
    end
  end

  describe "subtract/2" do
    test "delegate to Calculable" do
      a = FileSize.new(2, :b)
      b = FileSize.new(1, :b)

      assert FileSize.subtract(a, b) == Calculable.subtract(a, b)
    end
  end

  describe "subtract/3" do
    test "delegate to Calculable and convert" do
      a = FileSize.new(2, :b)
      b = FileSize.new(1, :b)

      assert FileSize.subtract(a, b, :kb) ==
               FileSize.convert(Calculable.subtract(a, b), :kb)
    end
  end
end
