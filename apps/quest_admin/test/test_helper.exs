ExUnit.start

Ecto.Adapters.SQL.Sandbox.mode(QuestAdmin.Repo, :manual)

import Supervisor.Spec
opts = [strategy: :one_for_one, name: QuestAdmin.TestSupervisor]
Supervisor.start_link([supervisor(QuestAdmin.Endpoint, [])], opts)

