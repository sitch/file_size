defmodule FileSize.Formatter do
  @default_symbols %{
    byte: "Bytes",
    kb: "kB",
    mb: "MB",
    gb: "GB",
    tb: "TB",
    pb: "PB"
  }

  @spec format(FileSize.t(), Keyword.t()) :: String.t()
  def format(size, opts \\ []) do
    number_opts = Keyword.take(opts, [:precision, :delimiter, :separator])
    value = Number.Delimit.number_to_delimited(size.value, number_opts)

    symbols = Keyword.get(opts, :symbols, @default_symbols)
    symbol = Map.fetch!(symbols, size.unit)

    "#{value} #{symbol}"
  end
end
