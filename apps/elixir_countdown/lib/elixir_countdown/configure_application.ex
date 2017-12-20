defmodule ElixirCountdown.Configuration do
	import Focus

	@appdb   :elixir_countdown
	@database ElixirCountdown.Repo
	@appweb   :elixir_countdown_web
	@endpoint ElixirCountdownWeb.Endpoint

	@envnames %{ 
		:endpoint => %{
			:host => "HOST",
			:port => "PORT",
			:secret_key_base => "SECRET_KEY_BASE",
			:cookie_signing_salt => "COOKIE_SIGNING_SALT"
		}, 
		:database => %{
			:connection_string => "DATABASE_CONNECTION_STRING",
			:pool_size => "DATABASE_CONNECTION_POOL_SIZE"
		},
		:auth0 => %{
			:domain => "AUTH0_DOMAIN",
			:mgmt_client_id => "AUTH0_MGMT_CLIENT_ID",
			:mgmt_client_secret => "AUTH0_MGMT_CLIENT_SECRET"
		}
	}

	@connectionStringRegex ~r"Database=(?<database>[^;]+);\s*Data Source=(?<hostname>[^;]+);\s*User Id=(?<username>[^;]+);\s*Password=(?<password>.+)"

	def initialize_config do
		dbParams = Regex.named_captures(@connectionStringRegex, get_env!(@envnames.database.connection_string))

		# :elixir_countdown ElixirCountdown.Repo


		IO.puts("init DB 2")
		set_cfg(@appdb, @database, [:database], dbParams["database"])
		IO.puts("init DB 3")
		set_cfg(@appdb, @database, [:hostname], dbParams["hostname"])
		set_cfg(@appdb, @database, [:username], dbParams["username"])
		set_cfg(@appdb, @database, [:password], dbParams["password"])
		set_cfg(@appdb, @database, [:pool_size], get_env!(@envnames.database.pool_size) |> String.to_integer)
		set_cfg(@appdb, @database, [:ssl], true)
		set_cfg(@appdb, @database, [:port], 5432)
		set_cfg(@appdb, @database, [:ssl_opts], [versions: [:"tlsv1.2"]])

		set_cfg(@appweb, @endpoint, [:url], [host: get_env!(@envnames.endpoint.host)])
		set_cfg(@appweb, @endpoint, [:http], [:inet, port: get_env!(@envnames.endpoint.port) |> String.to_integer])
		set_cfg(@appweb, @endpoint, [:secret_key_base], get_env!(@envnames.endpoint.secret_key_base))
		
		set_cfg(:auth0_ex, :domain, get_env!(@envnames.auth0.domain))
		set_cfg(:auth0_ex, :mgmt_client_id, get_env!(@envnames.auth0.mgmt_client_id))
		set_cfg(:auth0_ex, :mgmt_client_secret, get_env!(@envnames.auth0.mgmt_client_secret))
	end

	def cookie_signing_salt do
		get_env!(@envnames.endpoint.cookie_signing_salt)
	end

	defp get_env!(key) do
		System.get_env(key) || raise "expected the #{key} environment variable to be set"
	end

	defp lens_chain([head | []]), do: Lens.make_lens(head)
	defp lens_chain([head | tail]), do: Lens.make_lens(head) ~> lens_chain(tail)

	def get_val(structure, path) do
		lenses = lens_chain(path)
		Focus.view(lenses, structure)
	end
	
	defp set_val(structure, path, value) do
		lenses = lens_chain(path)
		Focus.set(lenses, structure, value)
	end

	def get_cfg(app, key, lens) do
		Application.get_env(app, key) |> get_val(lens) 
	end

	defp set_cfg(app, key, lens, new_val) do
		oldStruct = Application.get_env(app, key)
		newStruct = oldStruct |> set_val(lens, new_val) 
		Application.put_env(app, key, newStruct)
	end

	defp set_cfg(app, key, new_val) do
		Application.put_env(app, key, new_val)
	end
end