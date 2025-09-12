class Task < ApplicationRecord
  enum :status, { pending: 0, in_progress: 1, completed: 2, archived: 3 }
end