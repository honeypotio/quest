# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     QuestApi.Repo.insert!(%QuestApi.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias QuestApi.Repo
alias QuestApi.Question

questions = [
  %Question{
    code: "XYZQA",
    body: "What is the best programming language?"
  },
  %Question{
    code: "QQ123",
    body: "Your prefered text editor is?"
  },
  %Question{
    code: "FDR23",
    body: "Who was the last president of USA?"
  }
]

options = [
  "XYZQA": [
    %{
      code: "aaaaaa",
      body: "Elixir"
    }
  ],
  "QQ123": [
    %{
      code: "vvvvvv",
      body: "vim"
    },
    %{
      code: "eeeeee",
      body: "Emacs"
    }
  ],
  "FDR23": [
    %{
      code: "clinton",
      body: "Hillary Clinton"
    },
    %{
      code: "trump",
      body: "Donald Trump"
    }
  ]
]

Repo.transaction fn ->
  questions |> Enum.each(&Repo.insert!(&1))

  Keyword.keys(options) |> Enum.each(fn(question_code) ->
    question = Repo.get_by(Question, code: Atom.to_string(question_code))
    Keyword.fetch!(options, question_code) |> Enum.each(fn(option) ->
      new_option = Ecto.build_assoc(question, :options, Map.put(option, :question_id, question.id))
      Repo.insert!(new_option)
    end)
  end)
end
