ExUnit.start

Ecto.Adapters.SQL.Sandbox.mode(QuestApi.Repo, :manual)

import Supervisor.Spec
opts = [strategy: :one_for_one, name: QuestApi.TestSupervisor]
Supervisor.start_link([supervisor(QuestApi.Endpoint, [])], opts)
