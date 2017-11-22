defmodule Hangman.Server do 
  alias Hangman.Game, as: Game
  use GenServer
  
  # GenServer Client API
  def start_link() do
    GenServer.start_link(Hangman.Server, [], name: HangmanGenServer)
  end

  def new_game() do
    GenServer.call(HangmanGenServer, :new_game)
  end

  def new_game(word) do
    GenServer.call(HangmanGenServer, {:new_game, word})
  end

  def make_move(game, guess) do
    GenServer.call(HangmanGenServer, {:make_move, game, guess})
  end

  def tally(game) do
    GenServer.call(HangmanGenServer, {:tally, game})
  end
  
  #####
  # GenServer implementation

  def init([]) do
    {:ok, Game.new_game()}
  end

  def init(args) do
    {:ok, Game.new_game(args)}
  end

  def handle_call(:new_game, _from, state) do
    {:reply, Game.new_game(), state}
  end
  
  def handle_call({:new_game, word}, _from, state) do
    {:reply, Game.new_game(word), state}
  end

  def handle_call({:make_move, game, guess}, _from, state) do
    {:reply, Game.make_move(game, guess), state}
  end
  
  def handle_call({:tally, game}, _from, state) do
    {:reply, Game.tally(game), state}
  end

end
